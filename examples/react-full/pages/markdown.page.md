import { Counter } from '../components/Counter';

export const documentProps = {
title: 'Some Markdown Page'
};

# Markdown

This page is written in _Markdown_.

To use Markdown add `vite-plugin-mdx` to your `vite.config.js`.

MDX allows us to include interactive components in the markdown. <Counter/>
