---
name: Translation
about: Track the translation of WordPress Playground documentation into a new language.
title: "Translate documentation to [Language Name]"
labels:
  - "[Aspect] Internationalization (i18n)"
---

## Language
<!-- ✏️ Replace with the language name, e.g. Japanese. Update the issue title too. -->

## Locale code
LOCALE_CODE <!-- ✏️ Replace with the locale code for the i18n/ directory, e.g. ja, pt-br -->

## Translation resources
<!-- ✏️ Add helpful links for translators — glossaries, style guides, Polyglots pages, GlotPress links, etc. Delete this section if none. -->

- https://translate.wordpress.org/locale/LOCALE_CODE/default/ <!-- ✏️ Replace LOCALE_CODE -->

## How to contribute

Translations live in `i18n/LOCALE_CODE`. Each translated file should mirror the path and filename of the original English source in `docs/`. <!-- ✏️ Replace LOCALE_CODE -->

<!-- ✅ Done — leave everything below as-is. -->

For general guidance, see [Contributing: Translations](https://wordpress.github.io/wordpress-playground/contributing/translations).

1. Pick an unchecked file from the checklist below.
2. Leave a comment claiming it so others don't duplicate work.
3. Open a PR with the translated file at the matching path under `i18n/[locale code]/`.
4. Check off the file once the PR is merged.

## Remaining translation pages

<details open>
<summary><h3>Main</h3></summary>

- about
  - [ ] build.md
  - [ ] index.md
  - [ ] launch.md
  - [ ] test.md
- contributing
  - [ ] code.md
  - [ ] coding-standards.md
  - [ ] contributor-badge.md
  - [ ] contributor-day.md
  - [ ] contributor-day-table-lead.md
  - [ ] documentation.md
  - [ ] index.md
  - [ ] releases.md
  - [ ] translations.md
- guides
  - [ ] for-plugin-developers.md
  - [ ] for-theme-developers.md
  - [ ] github-action-pr-preview.md
  - [ ] index.md
  - [ ] providing-content-for-your-demo.md
  - [ ] wordpress-native-ios-app.md
- [ ] changelog.md
- [ ] intro.md
- [ ] quick-start-guide.md
- [ ] resources.md
- [ ] web-instance.md

</details>

<details open>
<summary><h3>Blueprints</h3></summary>

- [ ] 01-index.md
- [ ] 02-using-blueprints.md
- [ ] 03-data-format.md
- [ ] 04-resources.md
- [ ] 05-steps.md
- [ ] 05-steps-shorthands.md
- [ ] 06-bundles.md
- [ ] 07-json-api-and-function-api.md
- [ ] 08-examples.md
- [ ] 09-troubleshoot-and-debug-blueprints.md
- [ ] intro.md
- tutorial
  - [ ] 01-what-are-blueprints-what-you-can-do-with-them.md
  - [ ] 02-how-to-load-run-blueprints.md
  - [ ] 03-build-your-first-blueprint.md
  - [ ] index.md

</details>

<details open>
<summary><h3>Developers</h3></summary>

- 03-build-an-app
  - [ ] 01-index.md
- 05-local-development
  - [ ] 01-wp-now.md
  - [ ] 02-vscode-extension.md
  - [ ] 03-php-wasm-node.md
  - [ ] 04-wp-playground-cli.md
  - [ ] intro.md
- 06-apis
  - [ ] 01-index.md
  - javascript-api
    - [ ] 01-index.md
    - [ ] 02-index-html-vs-remote-html.md
    - [ ] 03-playground-api-client.md
    - [ ] 04-blueprint-json-in-api-client.md
    - [ ] 05-blueprint-functions-in-api-client.md
    - [ ] 06-mount-data.md
  - query-api
    - [ ] 01-index.md
- 07-xdebug
  - [ ] 01-introduction.md
  - [ ] 02-getting-started.md
- 23-architecture
  - [ ] 01-index.md
  - [ ] 02-wasm-php-overview.md
  - [ ] 03-wasm-php-compiling.md
  - [ ] 04-wasm-php-javascript-module.md
  - [ ] 05-wasm-php-filesystem.md
  - [ ] 07-wasm-asyncify.md
  - [ ] 08-browser-concepts.md
  - [ ] 09-browser-tab-orchestrates-execution.md
  - [ ] 10-browser-iframe-rendering.md
  - [ ] 11-browser-php-worker-threads.md
  - [ ] 12-browser-service-workers.md
  - [ ] 13-browser-scopes.md
  - [ ] 14-browser-cross-process-communication.md
  - [ ] 15-wordpress.md
  - [ ] 16-wordpress-database.md
  - [ ] 17-browser-wordpress.md
  - [ ] 18-host-your-own-playground.md
- 24-limitations
  - [ ] 01-index.md
- [ ] intro-devs.md

</details>
