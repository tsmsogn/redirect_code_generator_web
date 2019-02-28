require 'redirect_code_generator'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @permanent = true
  @escape = true
  @input = <<CODE
/old.html                /new.html
/old_dir/                /new_dir/
/old_user_dir/(.*)       /new_user_dir/$1
/old/?page=1&search=word /new/
http://old.com           http://new.com
http://old.com:8080      http://new.com
CODE

  erb :index
end

post '/' do
  @permanent = params[:permanent] ? true : false
  @escape = params[:escape] ? true : false
  @input = params[:input]

  codes = []
  @input.split("\n").each do |line|
    old, new = line.split
    codes << RedirectCodeGenerator.create_apache_redirect_code(old, new, @permanent, @escape)
  end

  @output = codes.join("\n")

  erb :index
end
