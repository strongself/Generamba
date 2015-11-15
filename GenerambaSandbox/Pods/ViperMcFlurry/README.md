# VIPER McFlurry

## Description

**VIPER McFlurry** is a modern framework for implementing VIPER architecture in iOS application. It offers several tools and components that helps either start new projects with VIPER or move from MVC.

Also it icludes **Templates** folder with XCode templates for VIPER modules.

## Install

**ViperMcFlurry**

Add to podfile

```ruby
pod "ViperMcFlurry"
```

**Templates**

Copy contents of *Templates/File Templates* folder into `~/Library/Developer/Xcode/Templates/File Templates`


## Authors

**Rambler&Co** team:

- Andrey Zarembo-Godzyatsky / a.zarembo-godyzatsky@rambler-co.ru
- Valery Popov / v.popov@rambler-co.ru
- Egor Tolstoy / e.tolstoy@rambler-co.ru

## Project History

### v0.1

- Forked VIPER components from internal projects

### v0.2 
- Added nil configurator/block support
- Module instantiation improvements

### v1.0 

- Added support of module input/output
- Module communication was simplified
- Moved Embed and Cross storyboard segues to separate Pods

### v1.1

- Moving to Github and Cocoapods


## How to add Intermodule transition ##

This works only for Module with ViewController as View.

- Create Module input protocol for target module inherited from 'RamblerViperModuleInput'

```
@protocol SomeModuleInput <RamblerViperModuleInput>

- (void)moduleConfigurationMethod;
		
@end
```    

- Make Presenter of target module conform to this protocol
- Inject Presenter as moduleInput property of the view. You can skip this step if presenter is a view property with name "output"
- Add Segue from source module ViewController to target module ViewController. 
- Inject Source ViewController into Source Router as property "transition handler"
- In Router method call transition handler to open target module with configuration during segue.

```
[[self.transitionHandler openModuleUsingSegue:SegueIdentifier]
	thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<SomeModuleInput> moduleInput) {
		[moduleInput moduleConfigurationMethod];
		return nil;
	}];

```

## Working with Module output ##

- Create Module output protocol for target module inherited from 'RamblerViperModuleOutput'

```
@protocol SomeModuleOutput <RamblerViperModuleOutput>

- (void)moduleConfigurationMethod;
		
@end
```    
- Make source module presenter to conform to this protocol
- Add to target module presenter method 

```
- (void)setModuleOutput:(id<RamblerViperModuleOutput>)moduleOutput;
```

- Return source module presenter from configuration block in router

```
[[self.transitionHandler openModuleUsingSegue:SegueIdentifier]
	thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<SomeModuleInput> moduleInput) {
		[moduleInput moduleConfigurationMethod];
		return sourceRouterPresenter; // Return of module output
	}];

```

## Working with Module Factory ##

Module factory can be replaced with segues for most cases. Except you need to create complex module or nontrivial module instantiation logic.

- Use **RamblerViperModuleFactory** object as module fabric with Typhoon.
- Set definition Initializer to **initWithStoryboard:andRestorationId:**
    - First parameter is UIStoryboard instance
    - Second parameter is RestorationID of ViewController
- Typhoon will initialize module from ViewController.
- Inject this Factory into router
- Call Transition Handler's method **openModuleUsingFactory:withTransitionBlock:**
- Second block is place where transition from one to another viewController/transitionHandler should be performed
```
    [[self.transitionHandler openModuleUsingFactory:self.betaModuleFactory
                                withTransitionBlock:^(id <RamblerViperModuleTransitionHandlerProtocol> sourceModuleTransitionHandler,
                                        id <RamblerViperModuleTransitionHandlerProtocol> destinationModuleTransitionHandler) {

                                    UIViewController *sourceViewController = (id) sourceModuleTransitionHandler;
                                    UIViewController *destinationViewController = (id) destinationModuleTransitionHandler;

                                    [sourceViewController.navigationController pushViewController:destinationViewController
                                                                                         animated:YES];

                                }] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<RamblerModuleBetaInput> moduleInput) {
                                   [moduleInput configureWithExampleString:exampleString];
                                   return nil;
                               }];
```
- In example above one module is pushed to navigation stack of another module
- Modules are linked with intermodule data transfer block