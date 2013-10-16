# ironFilings

ironFilings is a collection of short scripts and snippets for manipulating [eWater Source][source] using the
Iron languages (IronPython and IronRuby).

## Uses

The _niche_ for ironFilings are tasks that need to access or manipulate internal details of Source projects and scenarios, but would be tedious to implement as a plugin.

For the most part, ironFilings is intended for people who have some comfort with code. There is at least one tool that could be useful for end users [upgrade_directory.rb](rb/upgrade_directory.rb), which upgrades all the .rsproj files in a given directory to a new version of Source - handy if you have many projects and don't want to go through the upgrade process manually when loading into a new version.

ironFilings is useful for a number of things:

* Interactively modifying or querying models,
* Writing scripts to make bulk changes to models (or to perform special queries),
* Manually exercising the Source API to assist learning (eg when building a traditional plugin)

## Getting Started

To run ironFilings, you need one or both of the _Iron languages_ - IronPython and IronRuby - which are native .NET implementations of their namesake languages, Python and Ruby.

Both languages are free and open source, although [IronPython](http://ironpython.net/) seems to be the more active project. At the time of writing, [IronRuby](http://ironruby.codeplex.com/releases) hasn't had an official release in over two years, but it remains a very useful tool for manipulating .NET apps, such as Source.

I suspect that IronPython will appeal to more eWater Source users.

After installing one or more IronLanguages and downloading or cloning the ironFilings repo, you can explore the various scripts. Note, Source currently requires much of its data access layer to be configured via xml configuration files, which, because of the way IronRuby runs, needs to be associated with the IronRuby executable. The path of least resistance is to place these files (available in the rb directory) into the bin directory under the IronRuby installation. This is not at all a nice solution!

## Feedback

If you find ironFilings useful (or not) I'd certainly like to here it.

## License

ironFilings is licensed under the [LGPLv3]

[source]: http://www.ewater.com.au/products/ewater-source/
[LGPLv3]: http://www.gnu.org/copyleft/lesser.html
