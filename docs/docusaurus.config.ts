import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
    title: 'MapLibre Flutter',
    tagline: 'Permissive and performant mapping library that supports Mapbox Vector Tiles (MVT) powered by MapLibre SDKs.',
    favicon: 'img/favicon-32x32.png',

    // Set the production url of your site here
    url: 'https://flutter-maplibre.pages.dev',
    // Set the /<baseUrl>/ pathname under which your site is served
    // For GitHub pages deployment, it is often '/<projectName>/'
    baseUrl: '/',

    // GitHub pages deployment config.
    // If you aren't using GitHub pages, you don't need these.
    organizationName: 'josxha', // Usually your GitHub org / username.
    projectName: 'flutter-maplibre', // Usually your repo name.

    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',

    // Even if you don't use internationalization, you can use this field to set
    // useful metadata like html lang. For example, if your site is Chinese, you
    // may want to replace "en" with "zh-Hans".
    i18n: {
        defaultLocale: 'en',
        locales: ['en'],
    },

    markdown: {
        mermaid: true,
    },
    themes: ['@docusaurus/theme-mermaid'],

    presets: [
        [
            'classic',
            {
                docs: {
                    sidebarPath: './sidebars.ts',
                    // Please change this to your repo.
                    // Remove this to remove the "edit this page" links.
                    editUrl:
                        'https://github.com/josxha/flutter-maplibre/tree/main/docs/',
                },
                theme: {
                    customCss: './src/css/custom.css',
                },
            } satisfies Preset.Options,
        ],
    ],

    themeConfig: {
        // Replace with your project's social card
        // image: 'img/maplibre-social-card.jpg',
        navbar: {
            title: 'MapLibre Flutter',
            logo: {
                alt: 'MapLibre Logo',
                src: 'img/logo.svg',
            },
            items: [
                {
                    href: '/docs/getting-started/add-dependency',
                    sidebarId: 'docsSidebar',
                    position: 'left',
                    label: 'Getting Started',
                },
                {
                    href: '/docs/index/',
                    sidebarId: 'docsSidebar',
                    position: 'left',
                    label: 'Docs',
                },
                {
                    type: 'docsVersionDropdown',
                    position: 'left',
                },
                {
                    href: "https://pub.dev/documentation/maplibre/latest/maplibre/maplibre-library.html",
                    position: 'right',
                    label: 'API',
                },
                {
                    href: "pathname:///demo",
                    position: 'right',
                    label: 'Demo App',
                },
                {
                    href: 'https://github.com/josxha/flutter-maplibre',
                    position: 'right',
                    label: 'GitHub',
                },
                {
                    href: 'https://pub.dev/packages/maplibre',
                    position: 'right',
                    label: 'pub.dev',
                },
            ],
        },
        footer: {
            style: 'dark',
            links: [
                {
                    title: 'Documentation',
                    items: [
                        {
                            label: 'Getting Started',
                            to: '/docs/getting-started/add-dependency',
                        },
                        {
                            label: 'Docs',
                            to: '/docs/index/',
                        },
                        {
                            label: 'API Reference',
                            href: 'https://pub.dev/documentation/maplibre/latest/maplibre/maplibre-library.html',
                        },
                    ],
                },
                {
                    title: 'Community',
                    items: [
                        {
                            label: 'OpenStreetMap US Slack',
                            href: 'https://slack.openstreetmap.us',
                        },
                        {
                            label: 'StackOverflow',
                            href: 'https://stackoverflow.com/questions/tagged/maplibre-gl',
                        },
                        {
                            label: 'GitHub Discussions',
                            href: 'https://github.com/josxha/flutter-maplibre/discussions',
                        },
                    ],
                },
                {
                    title: 'Resources',
                    items: [
                        {
                            label: 'GitHub',
                            href: 'https://github.com/josxha/flutter-maplibre',
                        },
                        {
                            label: 'pub.dev',
                            href: 'https://pub.dev/packages/maplibre',
                        },
                        {
                            label: 'Demo App',
                            href: 'pathname:///demo',
                        },
                    ],
                },
            ],
            copyright: `Copyright © ${new Date().getFullYear()} josxha`,
        },
        prism: {
            theme: prismThemes.github,
            darkTheme: prismThemes.dracula,
            additionalLanguages: ['dart', 'bash', 'gradle'],
        },
    } satisfies Preset.ThemeConfig,
};

export default config;
