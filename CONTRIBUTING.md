# Contributing

We welcome contributions to this repository. Please follow these steps if
you're interested in making contributions:

## Preceding steps

1. Ensure that
   existing [pull requests](https://github.com/josxha/flutter-maplibre/pulls)
   and [issues](https://github.com/josxha/flutter-maplibre/issues) don’t
   already cover your contribution or question.
2. If your pull request will add a major or breaking change, please open a
   [feature request](https://github.com/josxha/flutter-maplibre/issues/new/choose)
   first to start a discussion.
3. The example app under [/example](/example) is used as a reference point.
   If you have a bug and can't tell if it's related to the package, please try
   to reproduce it with the example app or create some other way to reproduce
   your issue.
4. Ensure that what you have planned is possible by verifying this functionality
   is supported
   by [maplibre-native](https://github.com/maplibre/maplibre-native)
   and [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js).

## Start contributing

1. [Fork the repository](https://github.com/josxha/flutter-maplibre/fork) and
   push your changes to a new branch to avoid conflicts in your forked
   repository.
2. Along with your contribution please also adapt the example app to showcase
   any new features or APIs you have developed. This allows quick testing and
   gives evaluating users a better idea about the functionality of the package.
3. Consider updating
   the [documentation](https://github.com/josxha/flutter-maplibre/tree/main/docs/docs)
   to explain users how to implement.
4. If there are any changes that developers should be aware of, please update
   the [CHANGELOG.md](https://github.com/josxha/flutter-maplibre/blob/main/CHANGELOG.md)
   file together with your pull request.
5. If you change the [./pigeons/pigeon.dart](./pigeons/pigeon.dart) file, you'll
   have to run the [pigeon](https://pub.dev/packages/pigeon) code generation.
   You can use [./pigeons/run_code_gen.sh](./pigeons/run_code_gen.sh)
   or [./pigeons/run_code_gen.ps1](./pigeons/run_code_gen.ps1).
6. If you have a pull request that isn't complete yet and want to get
   feedback, consider
   to [open a draft pull request](https://github.com/josxha/flutter-maplibre/pulls).
   This helps others to get
   involved into the changes more early and allows to link the pull request to
   open issues. Give a quick summary about your changes listing any related
   issues that exist. Screenshots and videos are or course welcome, too.
   Use a [conventional](https://www.conventionalcommits.org/) title if you like.
7. When your contribution is ready to review, disable the draft state of your
   pull request and update the summary by editing your initial pull request
   message. This summary will go into the commit details of the squashed commit.

Thanks for every contribution you make to the project.