require 'rubygems'
require 'sinatra'

texfiles = ['./Week 1/imul/aflevering.tex',
            './Week 2/aflevering.tex',
            './Week 3/aflevering.tex',
            './Week 4/aflevering.tex']

get '/' do
  ob = ""
  texfiles.each do |file|
    ob += haml "%a{'href' => '/pdf/#{file}'} #{file}"
  end 
  ob
end

get '/pdf/*' do
  tex = params[:splat].first

  if(File.exists?(tex))
    tex = File.new(tex)
    cmd = "pdflatex -halt-on-error -output-directory=\"#{File.dirname(tex)}\" \"#{tex.path}\""
    pdf = "./#{File.dirname(tex)}/#{File.basename(tex, ".tex")}.pdf"
    puts "command: #{cmd}"
    puts `#{cmd}` if File.new(pdf).nil? || File::ctime(pdf) < File::ctime(tex)
    [200,
      {'Content-Type' => 'application/pdf'},
      File.read(pdf)] if File.exists?(pdf)
  else
    [404, "Error'd"]
  end
end