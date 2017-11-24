require "redirect_code_generator"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @permanent = true
  @escape = true
  @input = <<CODE
/old.html                /new.html
/old_dir/                /new_dir/
http://your-old-site.com http://your-new-site.com
CODE

  erb :index
end

post "/" do
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
