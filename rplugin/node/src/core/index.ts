import { NvimPlugin } from 'neovim';

export const findComments = (plugin: NvimPlugin) => {
  const run = async () => {
    await plugin.nvim.outWrite(`findComments`);
  };

  run();
};
