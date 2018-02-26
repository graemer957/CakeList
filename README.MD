Coding Test (fictitious)


***
NOTE: PLEASE DO NOT USE THIRD PARTY LIBRARIES. However, feel free to state which third party libraries you might have used.
***

Here you'll find the code for a simple mobile app to browse cakes.

Unfortunately, the developer who wrote this code is no longer employed by the company as we had some concerns over his ability.

The project compiles but the app crashes as soon as it runs. The app loads a JSON feed containing a repeated list of cakes, with title, image and description from a URL, then displays the contents of the feed in a scrollable list.

We would like you to fix the crash bug, ensure the functionality of the app works as expected (all images display correctly on the table, all text is readable) and performs smoothly (ideally, this should be done without third party libraries). You should also refactor, optimise and improve the code where appropriate to use platform best practises.

Please note that we are not looking for perfection, but rather for a clean and pragmatic solution. This should include refactoring but shouldn’t be over engineered. The test can be completed in 2-3 hours; howerever, this is a not a limit. Feel free to spend more time on it if you wish.

---

Dear Reviewer

Please see the branch named `modernisation`, taken from the head of the `seniorDev` branch. I have committed small and frequently in the hopes of making it easier to follow my thought process.

The overview of my changes are:
- Added .gitignore, would normally use company/client standard
- Fixed compilation error and crash due to mismatch of cell identifier
- Modernised the project and codebase, eg latest settings from Xcode 9.2, nullability annotations and lightweight generics
- Applied a consistent coding style
- Removed dead code
- Increased minimum iOS version to 10.0. I justify this with [App Store Usage](https://developer.apple.com/support/app-store/) showing earlier is ~7%.
- Added an immutable model, `Cake` to pass around, rather than an `NSDictionary`
- I chose to leave ATS enabled (for all the good reasons) and allow some images to fail to load due to validation issues (you will see these in the console)
- Separated networking and parsing into its own concern
- Made some layout and styling improvements
- You can now refresh the list of cakes using pull to refresh
- Fetching of cakes and images now happens asynchronously by using `NSURLSession`
- Images are now cached with `NSCache`
- You can now drill down into a cake to see more detailed information
- Works in portrait and landscape

This took just over 3 hours. Obviously still plenty of improvements that could still be made. Here are just a few:
- Better error handling. Right now it's output in console or ignored in the case of images
- Supply a default cake image
- Conversation of codebase to Swift 4, that would make the code safer, more concise, maintainable and allow us to use the fantastic `Codable` protocol

Thanks for your time.

G
