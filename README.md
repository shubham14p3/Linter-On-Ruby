# Linter-On-Ruby

Linter is a static analysis tool such as RuboCop. It checks the written code and makes suggestions based on pre-defined rules by community-driven coding style guides and common idioms.
Most definitions of linter default behavior can be changed for the needs of your team and project via various configuration options.

## Requirement for the projects:  
- A linter developed in Ruby
- It's a linter for beginners

Linter-On-Ruby is a beginner level linter that checks ruby .rb code files for the following rules:
- Maximum **100 lines** per file
- Check the susceptible for **def**
- Maximum **80 characters** per code line
- Check the susceptible for **class**
- Use of **two spaces** of indentation.
- Check the susceptible for **end**
- Exception **in the line** after a guard clause
- Check the susceptible for  **if**
- **No trailing spaces**
- Check the susceptible for **module**
- Lack of **EOF empty line**

## Example for Error-1

![screenshot](./images/Error1.PNG)

## Example for Error-2

![screenshot](./images/Error2.PNG)

## Folder Structure

![screenshot](./images/FileStructure.PNG)

## Built With

- Ruby
- RSpec
- VSCode (Windows Application)

# Getting started

To get a local copy of this repository up and running, follow these steps: 

- Click the **"Clone or download"** button or run the follwing command
  
  git clone https://github.com/shubham14p3/Linter-On-Ruby.git

- Remeber to change the extentions of files present in lib/students codes to following :- 
  - **"some_ruby_file.rb.txt"** to **"some_ruby_file.rb"**
  - **"student_code1.rb.txt"** to **"student_code1.rb"**
  - **"student_code2.rb.txt"** to **"student_code2.rb"**
  - **"student_code3.rb.txt"** to **"student_code3.rb"**
  - **"student_code4.rb.txt"** to **"student_code4.rb"**
  - **"student_code5.rb.txt"** to **"student_code5.rb"**
  - **"student_code6.rb.txt"** to **"student_code6.rb"**
  
- Type **ruby bin/main.rb** and press **[Enter]** and for 
- Type main.rb file/path/you/want/to/check.rb on command line and press **[Enter]**.
- To run Test cases just run **RSPEC** and press **[Enter]**

# Samples

### Indentation Cop 
Detects indentation with the rules of two spaces indentation.

#### \# Good
```
def my_method(arg1, arg2)
  variables = 12
end
```

#### \# Bad
```
def my_method(arg1, arg2)
  variables = 12
  end
```

### Max. 80 characters per line

#### \# Bad
```ruby
    if extra_large_condition1 && extra_large_condition2 && extra_large_condition3 && extra_large_condition4
```
#### \# Good
```ruby
    if extra_large_condition1 && extra_large_condition2 &&
      extra_large_condition3 && extra_large_condition4
```

### Soft Paranthese Missing Cop 
Calculates the total number of soft parantheses and returns the line number if closing and opening parantheses numbers doesn't match.

#### \# Good
```
def my_method(arg1, arg2)
  variables = 12
end
```

#### \# Bad
```
def my_method(arg1, arg2
  variables = 12
end
```
### Use of two spaces of indentation

#### \# Bad
```ruby
        name = 'Carlos'
        if name.length > 4
            puts "Hello #{name}!" # tab or more than 2 spaces 
        end
```
#### \# Good
```ruby
        name = 'Carlos'
        if name.length > 4
          puts "Hello #{name}!"
        end
```

### Square Bracket Missing Cop 
Does the same for square brackets.
#### \# Good
```
def my_method(arg1, arg2)
  variables = [12]
end
```

#### \# Bad
```
def my_method(arg1, arg2)
  variables = [12
end
```
### Exception in the line after a guard clause

#### \# Good
```ruby
        return unless File.exists?('file_name')
                          # empty line indentation can be 0 even if previous line is 4
        some other code
 ```

### Curly Bracket Missing Cop
Does the same for curly brackets.
#### \# Good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# Bad
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" 
end
```
### Missing  EOF empty line

#### \# Bad
```ruby
        name = 'Carlos'
        if name.length > 4
          puts "Hello #{name}!"
        end # file ends here
```
#### \# Good
```ruby
        name = 'Carlos'
        if name.length > 4
          puts "Hello #{name}!"
        end
        # file ends here
```
### Extra Space Cop 
It scans the lines and returns a note if it finds a bigger space than 1 character.
#### \# Good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# Bad
```
def my_method(arg1,     arg2)
  variables = { symbol: "sample" }
end
```
### No trailing spaces

#### \# Bad
```ruby
        puts 'Hello, world!' # invisible trailing space here
```
#### \# Good
```ruby
        puts 'Hello, world!'  # the line ends with the last single quote
```

### New Line Cop
If there is a keyword immediately before the 'end' keyword it returns an error message.

#### \# Good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end

def my_method2(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# Bad
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
def my_method2(arg1, arg2)
  variables = { symbol: "sample" }
end
```
### Keyword 'end' Missing Cop
If the keywords numbers doesn't match with the **end** numbers it returns an error message with the line number of the latest end.
#### \# Good
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }
end
```

#### \# Bad
```
def my_method(arg1, arg2)
  variables = { symbol: "sample" }

```
# Prerequisites
  
 You must have Ruby [installed on your computer](https://www.ruby-lang.org/en/documentation/installation/)
 
# Linters Error Descriptions 

Code in White Colors shows error for :-
- Maximum **100 lines** per file
- Maximum **80 characters** per code line
- Use of **two spaces** of indentation.
- Exception **in the line** after a guard clause
- **No trailing spaces**
- Lack of **EOF empty line**

Code in other Colors (Red, Yellow,etc) shows error for :-
- Check the susceptible for **def**
- Check the susceptible for **module**
- Check the susceptible for  **if**
- Check the susceptible for **end**
- Check the susceptible for **class**


## Authors

👤 Shubham Raj

- Github: [@ShubhamRaj](https://github.com/shubham14p3)
- Linkedin: [Shubham14p3](https://www.linkedin.com/in/shubham14p3/)

## Future updates  
- More specific conditions will be added.
_ More linters feature needs to be added.

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/shubham14p3/Linter-On-Ruby/issues/).

## Acknowledgments

- @Microverse
- My Family & Friends

## 📝 License

This project is [MIT](lic.url) licensed.
