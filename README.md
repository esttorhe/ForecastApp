# `MTTForecast`

This is a small application I did following [Pedro][pedro]'s `Framework`s «architecture» which basically is defined as follows: 
> Separate each layer into its own framework

The benefits are many, e.g.:

- Better separation of responsibilities
- Easier to test
- Less conflicts when multiple devs are working on the same project (but on different layers)

Overall this is perhaps not the best example but I think its a nice approach and I enjoyed doing it a lot.

## Running
This project is ready to open and compile.
Was written using `Xcode 7.3.1`.

To minimize potential issues the `Pods` directory is included in the project.

Due to the fact that the project uses `CocoaPods` you'll need to open `ForecastApp.xcworkspace` instead of the project file.

## Installation from scratch

If the project failed to compile or you would like to setup the project by hand (instead of using the provided pre-configured repo) follow the instructions bellow:

### `Makefile`
This project comes «equiped» with a `Makefile` that defines «macros» for most tasks to simplify the configuration and avoid potential issues.

To know what are the available tasks in the `Makefile` and know what they do simply run:

```console
make help
```

### Setting up the project

This project uses `CocoaPods` via a `Gemfile`.
In order to properly «install» you need to first run:

```console
gem install bundler
```

Once this is done you just need to run:

```console
make bundle
make pod
```

This will install all the gems listed in the `Gemfile` into a `bundle` located at `./.vendor` and then will execute `pod install` using the gem binary in the bundle.

This way every single developer that runs the project is doing it using the same tools as the rest of the team (same `CocoaPods` version, same `synx`, etc to avoid versioning issues).

---

*__Important note__: After running `make pod` you will be asked what's the `APIKey`, please enter the `API` key from the `WorldWeather` `API`.*

---

## Approaches | Architecture

The application was coded using a «Framework Development» approach.
This is basically separating some important layers into their own frameworks for better reusability.

With this approach the testing can be achieved better by separating concerns and responsabilities.

The main components of this app are as follow:

1. `WorldWeatherCore`: Core of the `WorldWeather` wrapper. Contains the definitions of all the models involved.
2. `WorldWeatherMappings`: This is the `JSON` parsing layer of the `Core` models. Separation is made because the data can come from many different sources and structures, thus bundling the parsing with the models would be a bad approach. This way the models are agnostic and this framework is solely in charge of mapping them from `JSON` into models.
3. `WorldWeatherAPI`: This layer is the one that directly interacts with the `WorldWeather` `API`, makes the requests and uses the 2 other frameworks to parse and return models as needed.

### Design Patterns
Besides the Framework Development approach this application was build using `MVVM`.

This was a personal choice given that I'm an advocate of `MVVM` and its benefits and also because the «parsing of data» to be consumed by the `View`s is «heavy» for this project and `MVVM` helps us better format data for user's consumption at the `ViewModel` level.

## Third party libraries

- `ModelMapper`: `Lyft`'s framework [`ModelMapper`][modelmapper] helps simplify `JSON` mapping into models. Avoids adding `as?` casting everywhere by implying the resulting `Type` based on the receiver of the parsing.
- `Moya`: [`Moya`][moya] is a great network abstraction layer. Is built on top of [`Alamofire`][af] and leverages the network layer by defining endpoints as enums. Comes with a built-in «offine/testing» mode that let's you use pre-saved `JSON` responses (makes testing easier).
- `SDWebImage`: Helps with the retrieval of remote images and loading them into `UIImageView`. Handles threading, caching and loading the remote images.
- `SwiftGen`: This is a `CLI` tool that helps add «strongly typed» features to the development process. Used in this project to generate strongly typed `ViewController` creation (can be used to generated localized strings, color literals and much more).

## Missing pieces

Here's a small list of things missing or that could be improved upon:

- No `UI` testing. Would have loved to add `Facebook` `Snapshot testing` to the project.
- Better internal documentation: I added header documentation on most of the low level frameworks but ran out of time by the `ViewModel`s and upper level classes. Would have loved to add more descriptive headers to the developer facing functions and properties.
- Better designed the `UI`: Right now the app is at a bare minimum not taking advantage of most of the data from the `WorldWeather` models. Also it looks pretty bad 🙈



[modelmapper]:https://github.com/lyft/mapper
[moya]:https://github.com/moya/moya
[af]:https://github.com/alamofire/alamofire
[pedro]:https://github.com/pepibumur
