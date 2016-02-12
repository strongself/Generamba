# Change Log

## [Unreleased](https://github.com/rambler-ios/Generamba/tree/HEAD)

[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.7.3...HEAD)

**Implemented enhancements:**

- Asks the user if he needed tests in `generamba setup` command [\#85](https://github.com/rambler-ios/Generamba/issues/85)
- Improve the visualization of commands with parameters [\#69](https://github.com/rambler-ios/Generamba/issues/69)

**Fixed bugs:**

- Add resources\(xib, storyboard and etc\) in project bundle resources. [\#84](https://github.com/rambler-ios/Generamba/issues/84)

**Merged pull requests:**

- Print table with summary info about input parameters [\#89](https://github.com/rambler-ios/Generamba/pull/89) ([Beniamiiin](https://github.com/Beniamiiin))
- Handle any resources in template and correct add to project [\#88](https://github.com/rambler-ios/Generamba/pull/88) ([Beniamiiin](https://github.com/Beniamiiin))
- Implemented new question, about need tests in `generamba setup` [\#87](https://github.com/rambler-ios/Generamba/pull/87) ([Beniamiiin](https://github.com/Beniamiiin))

## [0.7.3](https://github.com/rambler-ios/Generamba/tree/0.7.3) (2016-01-24)
[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.7.2...0.7.3)

**Implemented enhancements:**

- Enhance `generamba template search` to search templates in custom catalogs [\#75](https://github.com/rambler-ios/Generamba/issues/75)
- Enhance `generamba template list` to browse custom catalogs [\#74](https://github.com/rambler-ios/Generamba/issues/74)
- Warn the user if template contains missing dependencies [\#17](https://github.com/rambler-ios/Generamba/issues/17)
- Added method to check missing template dependencies in podfile [\#79](https://github.com/rambler-ios/Generamba/pull/79) ([Beniamiiin](https://github.com/Beniamiiin))

**Closed issues:**

- Can we use constants from rambafile in templates? [\#81](https://github.com/rambler-ios/Generamba/issues/81)
- Arguments for `generamba gen Name modulename` [\#80](https://github.com/rambler-ios/Generamba/issues/80)

**Merged pull requests:**

- Fixed crash when templates directory exists. [\#78](https://github.com/rambler-ios/Generamba/pull/78) ([mogol](https://github.com/mogol))

## [0.7.2](https://github.com/rambler-ios/Generamba/tree/0.7.2) (2016-01-10)
[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.7.1...0.7.2)

**Implemented enhancements:**

- --version command [\#54](https://github.com/rambler-ios/Generamba/issues/54)
- Incorrect behavior when generate module which already exists [\#52](https://github.com/rambler-ios/Generamba/issues/52)
- Add the ability to specify custom template catalogs in Rambafile [\#44](https://github.com/rambler-ios/Generamba/issues/44)

**Fixed bugs:**

- Don't set target in swift projects [\#65](https://github.com/rambler-ios/Generamba/issues/65)
- Errors if default path is empty [\#64](https://github.com/rambler-ios/Generamba/issues/64)
- Default template set can not be used [\#60](https://github.com/rambler-ios/Generamba/issues/60)
- Incorrect behavior when generate module which already exists [\#52](https://github.com/rambler-ios/Generamba/issues/52)

**Closed issues:**

- Can generamba be used to generate swift modules? [\#61](https://github.com/rambler-ios/Generamba/issues/61)
- Git 1.2.9.1 [\#57](https://github.com/rambler-ios/Generamba/issues/57)
- Clarify generamba parameters usage [\#51](https://github.com/rambler-ios/Generamba/issues/51)
- Add documentation for liquid templates [\#48](https://github.com/rambler-ios/Generamba/issues/48)
- The documentation is not translated into English [\#13](https://github.com/rambler-ios/Generamba/issues/13)

**Merged pull requests:**

- Feature/custom catalogs [\#73](https://github.com/rambler-ios/Generamba/pull/73) ([etolstoy](https://github.com/etolstoy))
- Added `generamba version` command [\#67](https://github.com/rambler-ios/Generamba/pull/67) ([etolstoy](https://github.com/etolstoy))
- Fixed \#64: Errors if default path is empty [\#66](https://github.com/rambler-ios/Generamba/pull/66) ([Beniamiiin](https://github.com/Beniamiiin))
- Added error display, if not specify at least one template in Rambafile \#60 [\#63](https://github.com/rambler-ios/Generamba/pull/63) ([Beniamiiin](https://github.com/Beniamiiin))
- Fixed \#52 - Incorrect behavior when generate module which already exists [\#59](https://github.com/rambler-ios/Generamba/pull/59) ([Beniamiiin](https://github.com/Beniamiiin))
- docs, link to Rambafile when it mentioned [\#58](https://github.com/rambler-ios/Generamba/pull/58) ([MaksimBazarov](https://github.com/MaksimBazarov))
- Fixed incorrect group path [\#56](https://github.com/rambler-ios/Generamba/pull/56) ([Beniamiiin](https://github.com/Beniamiiin))
- Docs translated to english \(\#13\) [\#55](https://github.com/rambler-ios/Generamba/pull/55) ([novixon](https://github.com/novixon))

## [0.7.1](https://github.com/rambler-ios/Generamba/tree/0.7.1) (2015-12-20)
[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.7.0...0.7.1)

**Implemented enhancements:**

- Podfile path setup during generamba setup needs clarification [\#50](https://github.com/rambler-ios/Generamba/issues/50)
- Remove the Settingslogic dependency [\#42](https://github.com/rambler-ios/Generamba/issues/42)

**Fixed bugs:**

- Unexpected behavior when use --module\_path  [\#53](https://github.com/rambler-ios/Generamba/issues/53)

**Closed issues:**

- Add support for multiple targets during generamba setup [\#49](https://github.com/rambler-ios/Generamba/issues/49)

**Merged pull requests:**

- Feature/settingslogic remove [\#47](https://github.com/rambler-ios/Generamba/pull/47) ([etolstoy](https://github.com/etolstoy))

## [0.7.0](https://github.com/rambler-ios/Generamba/tree/0.7.0) (2015-12-13)
[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.6.2...0.7.0)

**Implemented enhancements:**

- Add coloured output [\#28](https://github.com/rambler-ios/Generamba/issues/28)
- Add -filepath and -grouppath options for `generamba gen` command [\#27](https://github.com/rambler-ios/Generamba/issues/27)
- Add a `generamba template search` command [\#26](https://github.com/rambler-ios/Generamba/issues/26)
- Add a `generamba template list` command [\#25](https://github.com/rambler-ios/Generamba/issues/25)
- Add the if statements to the Rambafile.liquid [\#22](https://github.com/rambler-ios/Generamba/issues/22)
- Target membership for module sources [\#11](https://github.com/rambler-ios/Generamba/issues/11)

**Fixed bugs:**

- Non-informative error message when running `generamba template install` in the wrong directory [\#39](https://github.com/rambler-ios/Generamba/issues/39)
- undefined method `each' for nil:NilClass \(NoMethodError\) [\#37](https://github.com/rambler-ios/Generamba/issues/37)

**Merged pull requests:**

- Feature/multiple targets [\#43](https://github.com/rambler-ios/Generamba/pull/43) ([etolstoy](https://github.com/etolstoy))
- Feature/colored output [\#40](https://github.com/rambler-ios/Generamba/pull/40) ([etolstoy](https://github.com/etolstoy))
- Feature/gen file flags [\#38](https://github.com/rambler-ios/Generamba/pull/38) ([etolstoy](https://github.com/etolstoy))

## [0.6.2](https://github.com/rambler-ios/Generamba/tree/0.6.2) (2015-11-25)
[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.6.1...0.6.2)

**Fixed bugs:**

- Can't install template from git repo  [\#36](https://github.com/rambler-ios/Generamba/issues/36)
- Can't find template by local fullpath [\#35](https://github.com/rambler-ios/Generamba/issues/35)

**Closed issues:**

- Need more information about dependencies  [\#34](https://github.com/rambler-ios/Generamba/issues/34)

**Merged pull requests:**

- Mention the Ruby 2.2+ requirement in README [\#33](https://github.com/rambler-ios/Generamba/pull/33) ([rodionovd](https://github.com/rodionovd))

## [0.6.1](https://github.com/rambler-ios/Generamba/tree/0.6.1) (2015-11-21)
[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.6.0...0.6.1)

**Implemented enhancements:**

- Add Rambafile validation [\#10](https://github.com/rambler-ios/Generamba/issues/10)

**Fixed bugs:**

- The author name should be configured without `generamba setup` [\#31](https://github.com/rambler-ios/Generamba/issues/31)
- Sometimes Generamba fills in the wrong test target in the Rambafile [\#30](https://github.com/rambler-ios/Generamba/issues/30)
- Seems that Generamba doesn't add project name to the headers [\#29](https://github.com/rambler-ios/Generamba/issues/29)

**Closed issues:**

- Add a documentation for a .rambaspec file and overall template structure [\#24](https://github.com/rambler-ios/Generamba/issues/24)
- Rambafile format is not documented [\#9](https://github.com/rambler-ios/Generamba/issues/9)

## [0.6.0](https://github.com/rambler-ios/Generamba/tree/0.6.0) (2015-11-15)
[Full Changelog](https://github.com/rambler-ios/Generamba/compare/0.5.0...0.6.0)

**Implemented enhancements:**

- Add a podfile\_path/cartfile\_path fields to a Rambafile [\#19](https://github.com/rambler-ios/Generamba/issues/19)
- Add a dependencies field to the .rambaspec [\#18](https://github.com/rambler-ios/Generamba/issues/18)
- Move the hardcoded keys to the constants [\#15](https://github.com/rambler-ios/Generamba/issues/15)
- Implement automatic template creation [\#8](https://github.com/rambler-ios/Generamba/issues/8)
- Change some of the questions of `generamba setup` [\#7](https://github.com/rambler-ios/Generamba/issues/7)
- Implement installation of templates from the remote git repository [\#6](https://github.com/rambler-ios/Generamba/issues/6)
- Implement installation of templates with local filepath [\#5](https://github.com/rambler-ios/Generamba/issues/5)
- Remove the author-specific information from Rambafile [\#1](https://github.com/rambler-ios/Generamba/issues/1)

**Fixed bugs:**

- Rambafile uses absolute filepath to xcodeproj file [\#21](https://github.com/rambler-ios/Generamba/issues/21)
- Duplicate file reference in project.pbxproj [\#20](https://github.com/rambler-ios/Generamba/issues/20)
- Move the rambler\_viper\_controller template to the generamba-catalog [\#16](https://github.com/rambler-ios/Generamba/issues/16)
- The output of `setup` command is splitted sometimes [\#4](https://github.com/rambler-ios/Generamba/issues/4)
- Files are generated with incorrect filepaths [\#3](https://github.com/rambler-ios/Generamba/issues/3)

**Merged pull requests:**

- Feature/template creation [\#23](https://github.com/rambler-ios/Generamba/pull/23) ([etolstoy](https://github.com/etolstoy))
- Added command: generamba template install [\#14](https://github.com/rambler-ios/Generamba/pull/14) ([etolstoy](https://github.com/etolstoy))
- Feature/cli improvements [\#12](https://github.com/rambler-ios/Generamba/pull/12) ([AndreyZarembo](https://github.com/AndreyZarembo))
- Master [\#2](https://github.com/rambler-ios/Generamba/pull/2) ([etolstoy](https://github.com/etolstoy))

## [0.5.0](https://github.com/rambler-ios/Generamba/tree/0.5.0) (2015-11-01)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*