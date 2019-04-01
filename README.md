# Instant Shakespeare

![Instant Shakespeare](https://i.imgur.com/9jUNGau.gif)

An app that allows you to randomly grab a Shakespeare sonnet. Includes night mode, and line count for a better Shakespeare reading experience.

I'm using [PoetryDB](http://poetrydb.org/index.html) to get the sonnets themselves, and it is licensed under the [GNU Public License v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).

## Targets, Instructions, other Logistics

I don't have an iOS developer account. Actually, this is my first time building a full-on mobile app!

The device I simulated was the **iPhone X**, running on **iOS 12.1**. So it'd probably be best if you ran it on that platform.

I have no special instructions. Just an ordinary Flutter app. I only used [http](https://pub.dartlang.org/packages/http) and [RxDart](https://pub.dartlang.org/packages/rxdart) as far as external dependencies go.

Maybe just `flutter packages get` to install `http` and `rxdart`?

## Why did I build this?

* Current poetry reading solutions on mobile are not that great.
* One of my friends off-handedly mentioned Flutter, and it sounded interesting.
* I wanted to break into getting to know [ReactiveX](http://reactivex.io/) in some way, as well as the BLoC pattern.
* I wanted to create something that inched towards a _good_ poetry reader on mobile. That includes theme changing and line count.
* Really, I just love Shakespeare.


## Architecture/Technical Details

Thankfully this happened to be **5,118 bytes** using the `find` command! lol

Anyways, I only really used `rxdart` for state management, and `http` for getting data from the API.

I tried to conform to the **BLoC Pattern** as much as I could from one night of reading about it.

I have my BLoCs in the `bloc` folder:

* one for theme data, `theme_bloc.dart` (in a future iteration of this app, I hoped to give the users options to select more themes than just dark mode and light mode)
* one for sonnet data, `sonnet_bloc.dart`.

In the `data` folder, I have `get_sonnet.dart`, whose sole purpose is to provide a Singleton `SonnetAPI` object to request data from PoetryDB.

In `models`, I have `sonnet.dart`, which contains a `Sonnet` class to de-serialize the responses from the server.

Pretty much all of my UI data is in `main.dart`, and it relies upon those three things.

For really throwaway-ish UI functions, like line numbers and sonnet number changing on the view, I used a plain old `setState`. Honestly, there's probably a better way to do that stuff than I did with BLoCs, but I'm not adept enough yet with the BLoC pattern or RxDart to know any better.

## Regrets/Future Iterations

* If I had more space than 5kb, I would have included a loading view.
* I couldn't figure out how to app icon. This is literally my first time developing a full-blown mobile app. I'm a frontend web developer, and I've only toyed around with React Native before.
* In future iterations, I want to include a way to save sonnets with SQLite, line highlighting, and more poets.

## License

MIT License.

I've included a copy of the license in this folder.