### Overview

[![Gem Version](https://badge.fury.io/rb/generamba.svg)](https://badge.fury.io/rb/generamba)

**Generamba** is a code generator made for working with Xcode. Primarily it is designed to generate VIPER modules but it is quite easy to customize it for generation of any other classes.

![Generamba Screenshot](http://s11.postimg.org/ixp90vfr7/generamba.jpg)

### Key features

- Supports work with *.xcodeproj* files out of the box. All generated class files are automaticly placed on specific folders and groups of Xcode project.
- Can generate both code itself and tests adding them to right targets.
- Based on work with [liquid-templates](https://github.com/Shopify/liquid) that have plain and readable syntax in comparison with templates for Xcode.
- It is very easy to create a new module: `generamba gen [MODULE_NAME] [TEMPLATE_NAME]`. You do not need to input a bunch of data each time because each project corresponds to only one configuration file that holds standard file system and Xcode-project pathes, names of targets, information about the author.

### Installation

> Ruby 2.2 or later version is required. To check your current Ruby version run this command in terminal:
```bash
$ ruby --version
```
When necessary you can install the required Ruby version with the help of [`rvm`](http://octopress.org/docs/setup/rvm/) or [`rbenv`](http://octopress.org/docs/setup/rbenv/).

Run the command `gem install generamba`.

### Using
1. Run `generamba setup` in the project root folder. This command helps to create *Rambafile* that define all configuration needed to generate code. You can modify this file directly in future.
2. Add all templates planned to use in the project to the generated *Rambafile*. You can begin with one of the templates from our catalog: `{name: 'rviper_controller'}`.
3. Run `generamba template install`. All the templates will be placed in the '/Templates' folder of your current project.
4. Run `generamba gen [MODULE_NAME] [TEMPLATE_NAME]` - It creates module with specific name from specific template.


### Additional info

Run `generamba help` to learn more about each of the Generamba features.
- [Understanding the Rambafile](https://github.com/rambler-ios/Generamba/wiki/%D0%A1%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0-Rambafile)
- [Understanding templates](https://github.com/rambler-ios/Generamba/wiki/%D0%A1%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0-%D1%88%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D0%B0)

### Authors

- Rambler.iOS team

### License

MIT
