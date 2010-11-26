require 'rubygems'
require 'sinatra'


get '/' do
  ob = ""
  Dir.new('.').entries.each do |dir|
    ob += haml "%a{'href' => '#{dir}'} #{dir}" unless dir =~ /\.|\.\./
  end 
  ob
end

get '/:week' do |week|
  tex = File.new("./#{week.chomp}/aflevering.tex")
  if(File.exists?(tex))
    pdf = File.new("./#{week}/aflevering.pdf") if File.exist?("./#{week}/aflevering.pdf")
    cmd = "pdflatex -halt-on-error -output-directory=\"#{week}\" \"#{tex.path}\""
    puts "command: #{cmd}"
    puts `#{cmd}` if pdf.nil? || File::ctime(pdf) < File::ctime(tex)
    [200,
      {'Content-Type' => 'application/pdf'},
      File.read("./#{week}/aflevering.pdf")] if File.exists?("./#{week}/aflevering.pdf")
  else
    404
  end
end