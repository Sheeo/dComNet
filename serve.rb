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
  tex = "./#{week}/aflevering.tex"
  if(File.exists?(tex))
    pdf = "./#{week}/aflevering.pdf"
    `pdflatex #{tex}` unless File.exist?(pdf)
    [200,
      {'Content-Type' => 'application/pdf'},
      File.read("./#{week}/aflevering.pdf")]
  else
    404
  end
end