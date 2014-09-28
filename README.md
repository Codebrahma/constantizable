##Constantizable

[![Gem Version](https://badge.fury.io/rb/constantizable.svg)](http://badge.fury.io/rb/constantizable)
[![Code Climate](https://codeclimate.com/github/Codebrahma/constantizable/badges/gpa.svg)](https://codeclimate.com/github/Codebrahma/constantizable)
[![Dependency Status](https://gemnasium.com/Codebrahma/constantizable.svg)](https://gemnasium.com/Codebrahma/constantizable)
[![Build Status](https://travis-ci.org/Codebrahma/constantizable.svg)](https://travis-ci.org/Codebrahma/constantizable)

By [CodeBrahma](http://codebrahma.com).

Constantizable is a rails plugin which gives you an elegant way to query constant tables and inquire constant table objects.

``` ruby
# Let's say you have a model Country which stores the names of 
# all the countries in the world, and a User model which belongs_to
# a country.

user = User.all.sample

# without constantizable
user.update(:country => Country.find_by_name("India"))
user.country.name == "India" #Hard code that shit!

# with constantizable
user.update(:country => Country.india)
user.country.eql? Country.india
```

---

##Getting Started

Add it to your Gemfile with:

``` ruby
gem 'constantizable'
```

In each of your constant table models, specify the attribute that needs to be constantized.

``` ruby
class Country < ActiveRecord::Base
  constantize_column :name
end
```

That's it.

``` ruby
Country.united_states_of_america #<Country id: 3, name: "United States Of America"> 
Country.india.india? #true
```

---

Built by [sarka](https://twitter.com/sarka_neo), [yuva](https://twitter.com/Charizard_) and [nithin](https://twitter.com/nithinkrishh)
