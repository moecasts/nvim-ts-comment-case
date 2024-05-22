import { NvimPlugin } from 'neovim';
import { transform } from './core';

export const setup = (plugin: NvimPlugin) => {
  plugin.setOptions({ dev: false });

  plugin.registerCommand(
    'TsCommentCaseReplaceRange',
    async (cursor: [number, number]) => {
      const start = cursor[0] - 1;
      const end = cursor[1];

      // @ts-ignore
      const oldContent = (await plugin.nvim.buffer.getLines({
        start,
        end,
        strictIndexing: true,
      }));

      const newContent = transform(oldContent.join('\n')).split('\n');

      // @ts-ignore
      await plugin.nvim.buffer.setLines(newContent, {
        start,
        end,
        strictIndexing: false,
      });
    },
    { sync: false, range: '' },
  );

  plugin.registerCommand(
    'TsCommentCaseReplaceAll',
    async () => {
      const oldContent = (await plugin.nvim.buffer.lines);

      const newContent = transform(oldContent.join('\n')).split('\n');

      // @ts-ignore
      await plugin.nvim.buffer.setLines(newContent, {
        start: 0,
        end: -1,
        strictIndexing: false,
      });
    },
    { sync: false },
  );
};
