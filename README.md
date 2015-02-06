# ruby-rpg
A fast RPG Framework for Ruby using libgosu.

# How to set up your Linux
* You need to have [Ruby](https://www.ruby-lang.org/) installed (2.1 is recomended).
* Install libgosu dependencies:

> ``# apt-get install build-essential libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libfreeimage-dev libopenal-dev libsndfile-dev``

* Install gosu gem:

> ``gem install gosu``

# How to set up your Windows
It's not so easy like Linux, but here is the steps:

* You need to have [Ruby](https://www.ruby-lang.org/) installed. I really recomend this [standalone](http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller-2.1.5.exe?direct). Remember to add ruby executables to system path.

* Download the [DevKit](http://cdn.rubyinstaller.org/archives/devkits/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe) and extract in some directory (ex.: C:/DK).

* Open CMD Prompt, enter in the DevKit directory and install. Example:

> ``cd C:/DK``

> ``ruby dk.rb init``

> ``ruby dk.rb install``

* So install gosu gem and be happy:

> ``gem install gosu``

# Running examples
Clone the repository, and run some example from the main directory. Example: 

> ``ruby example/example01.rb``

# Considerations
I'm actually building a tutorial using a lot of actions to make more easy to understand the framework. Need help with YARD... If someone can help me, mail me: emanuelbotelho@ymail.com
