import React from 'react';
import ComponentCreator from '@docusaurus/ComponentCreator';

export default [
  {
    path: '/scaling-plugin/doc/build/blog',
    component: ComponentCreator('/scaling-plugin/doc/build/blog', 'a4e'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/archive',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/archive', '9e1'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/first-blog-post',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/first-blog-post', '83f'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/long-blog-post',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/long-blog-post', '3aa'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/mdx-blog-post',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/mdx-blog-post', 'c9c'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/tags',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/tags', '81c'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/tags/docusaurus',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/tags/docusaurus', 'd1c'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/tags/facebook',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/tags/facebook', '9be'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/tags/hello',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/tags/hello', '5e8'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/tags/hola',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/tags/hola', '4e3'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/blog/welcome',
    component: ComponentCreator('/scaling-plugin/doc/build/blog/welcome', '413'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/markdown-page',
    component: ComponentCreator('/scaling-plugin/doc/build/markdown-page', '1f8'),
    exact: true
  },
  {
    path: '/scaling-plugin/doc/build/docs',
    component: ComponentCreator('/scaling-plugin/doc/build/docs', '296'),
    routes: [
      {
        path: '/scaling-plugin/doc/build/docs/category/tutorial---basics',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/category/tutorial---basics', '729'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/category/tutorial---extras',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/category/tutorial---extras', '619'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/intro',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/intro', '4e3'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-basics/congratulations',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-basics/congratulations', '027'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-basics/create-a-blog-post',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-basics/create-a-blog-post', '842'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-basics/create-a-document',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-basics/create-a-document', 'ca5'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-basics/create-a-page',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-basics/create-a-page', 'fce'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-basics/deploy-your-site',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-basics/deploy-your-site', '888'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-basics/markdown-features',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-basics/markdown-features', '7c9'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-extras/manage-docs-versions',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-extras/manage-docs-versions', '399'),
        exact: true,
        sidebar: "tutorialSidebar"
      },
      {
        path: '/scaling-plugin/doc/build/docs/tutorial-extras/translate-your-site',
        component: ComponentCreator('/scaling-plugin/doc/build/docs/tutorial-extras/translate-your-site', '654'),
        exact: true,
        sidebar: "tutorialSidebar"
      }
    ]
  },
  {
    path: '/scaling-plugin/doc/build/',
    component: ComponentCreator('/scaling-plugin/doc/build/', 'bf7'),
    exact: true
  },
  {
    path: '*',
    component: ComponentCreator('*'),
  },
];
