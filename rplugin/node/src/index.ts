import { NvimPlugin } from 'neovim';
import { readFileSync } from 'node:fs';
import { forEachComment, forEachToken } from 'tsutils/util';

import { findComments } from './core';

import * as ts from 'typescript';

const transformCommentIntoJSDocStyle = (comment: string) => {};

/**
 * transform comment from `/** *\/` to `//`
 */
const transformCommentIntoSingleLineStyle = (comment: string) => {
  if (!/\/\*([\s\S]*)\*\//.test(comment)) {
    return comment;
  }

  const lines = comment.split('\n');
  const transformedLines = lines.map(line => {
    const startCommentRegex = /\/\*\s*/;
    const endCommentRegex = /\s*\*\//;
    const contentCommentRegex = /(\s*?)( ?\*)(.*)/;
    const EMPTY = undefined;

    if (startCommentRegex.test(line)) {
      return EMPTY;
    }

    if (endCommentRegex.test(line)) {
      return EMPTY;
    }

    const result = contentCommentRegex.exec(line);
    const [_, indent, _prefix, text] = result || [];

    if (!text) {
      return EMPTY;
    }

    return `${indent}//${text}`;
  });

  return transformedLines
    .filter(line => typeof line !== 'undefined')
    .join('\n')
    .trim();
};

const run = async () => {
  const content = readFileSync(
    '/Users/caster/Developments/self/nvim/nvim-ts-comment-case/tests/ts_comment_case/materials/code.ts',
    {
      encoding: 'utf8',
      flag: 'r',
    },
  );

  const src = ts.createSourceFile(
    'code.ts',
    content,
    //     `  /**
    //    * JSDoc comment 2
    //    * @description this is a JSDoc comment description
    //    */
    // `,
    ts.ScriptTarget.Latest,
    true,
  );

  let transformedContent = src.getFullText();
  let offset = 0;

  forEachComment(src, (fullText, commentRange) => {
    const comments = fullText.slice(commentRange.pos, commentRange.end);

    const replacedComments = transformCommentIntoSingleLineStyle(comments);
    const diffLength = replacedComments.length - comments.length;

    console.log('debug1', comments);

    transformedContent =
      transformedContent.slice(0, commentRange.pos + offset) +
      replacedComments +
      transformedContent.slice(commentRange.end + offset);

    offset += diffLength;
  });

  console.log(transformedContent);

  // const leadingCommentRanges = ts.getLeadingCommentRanges(
  //   src.getFullText(),
  //   src.getFullStart(),
  // );
  //
  // const trailingCommentRanges = ts.getTrailingCommentRanges(
  //   src.getFullText(),
  //   0,
  // );
  //
  // const getComments = (text: string, commentRanges: ts.CommentRange[] = []) => {
  //   const comments = commentRanges.map(commentRange => {
  //     return text.slice(commentRange.pos, commentRange.end);
  //   });
  //
  //   return comments;
  // };
  //
  // ts.forEachLeadingCommentRange(
  //   src.getFullText(),
  //   src.getFullStart(),
  //   (pos, end, kind) => {
  //     console.log('debug1 forEachLeadingCommentRange', {
  //       pos,
  //       end,
  //       kind,
  //       text: src.getFullText().slice(pos, end),
  //     });
  //   },
  // );
  //
  // ts.forEachTrailingCommentRange(src.getFullText(), 200, (pos, end, kind) => {
  //   console.log('debug1 forEachTrailingCommentRange', {
  //     pos,
  //     end,
  //     kind,
  //     text: src.getFullText().slice(pos, end),
  //   });
  // });

  // console.log('debug1 source', {
  //   content,
  //   // src,
  //   leadingCommentRanges,
  //   trailingCommentRanges,
  //   leadingComment: getComments(src.getFullText(), leadingCommentRanges),
  //   trailingComment: getComments(src.getFullText(), trailingCommentRanges),
  // });
};

run();

export const setup = (plugin: NvimPlugin) => {
  plugin.setOptions({ dev: false });

  plugin.registerCommand(
    'EchoMessage',
    async () => {
      try {
        // await plugin.nvim.outWrite('Dayman (ah-ah-ah) \n');
        const source = readFileSync(
          '/Users/caster/Developments/self/nvim/nvim-ts-comment-case/tests/ts_comment_case/materials/code.ts',
          {
            encoding: 'utf8',
            flag: 'r',
          },
        );

        await plugin.nvim.outWrite(`source: ${source}`);
      } catch (err) {
        console.error(err);
        if (err instanceof Error) {
          await plugin.nvim.outWrite(`${err.message} \n`);
        }
      }
    },
    { sync: false },
  );

  plugin.registerFunction(
    'SetLines',
    () => {
      return plugin.nvim
        .setLine('May I offer you an egg in these troubling times')
        .then(() => console.log('Line should be set'));
    },
    { sync: false },
  );

  plugin.registerAutocmd(
    'BufEnter',
    async (fileName: any) => {
      // await plugin.nvim.buffer.append('BufEnter for a JS File?');
      // await plugin.nvim.buffer.append('BufEnter for a JS File?');
    },
    { sync: false, pattern: '*.js', eval: 'expand("<afile>")' },
  );
};
