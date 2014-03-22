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

## Some common traps

### Name Conversions

The Ruby convention for method and property names is `lower_case_with_underscores`, as opposed to the .NET convention of `CamelCase`. IronyRuby attempts convert for you, so if the .NET class has a method called `MethodName`, asking an object of that class for its `.methods` from IronRuby will include `method_name`. 

For example, with the following C# class

~~~csharp
public class AnyOldClass {
  public void AnyOldMethod() { }
}
~~~

then the following IronRuby code will work:

~~~ruby
o = AnyOldClass.new
o.any_old_method
~~~

The problems come when the methods in the .NET class _don't follow the .NET naming conventions. A common one in the Source codebase at the time of writing is to lead with a lower case letter (ala Java conventions):

~~~csharp
public class AnyOldClass {
  public void anyOldMethod() { }
}
~~~

IronRuby will still convert the C# `anyOldMethod()` to the Ruby name `any_old_method` and this will get listed in a call to `.methods`, BUT if you attempt to call it, then it will fail with an `undefined method` error, because it's tried to __convert back__ to `AnyOldMethod`, which doesn't exist.

The solution in these circumstances to use the actual C# name in your Ruby. ie

~~~ruby
o = AnyOldClass.new
# o.any_old_method WON'T work
o.anyOldMethod # will work
~~~

### Iron Ruby versions

The Ruby examples were developed and tested using Iron Ruby 1.1.3, running on .NET 4.5. However, at least one user has reported problems with this combination. The issues we've seen occur in trying to initialise a .NET array of Type objects (eg with `System::Array.of(System::Type).new(0))`), with a complaint about no default constructor. This error has been avoided by compiling Iron Ruby 1.1.4 from [source][irsource].


## Feedback

If you find ironFilings useful (or not) I'd certainly like to here it.

## License

ironFilings is licensed under the [LGPLv3]

[irsource]: https://github.com/IronLanguages
[source]: http://www.ewater.com.au/products/ewater-source/
[LGPLv3]: http://www.gnu.org/copyleft/lesser.html
