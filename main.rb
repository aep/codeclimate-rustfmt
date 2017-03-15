#!/usr/bin/env ruby

require 'codeclimate_engine'
require 'nokogiri'
require 'pp'
require 'optparse'
require 'json'

config = JSON.parse(File.read('/config.json'))

xml_doc  = Nokogiri::XML(`find '#{config["include_paths"].join("' '")}' -name '*.rs' | xargs ~/.cargo/bin/rustfmt --write-mode checkstyle`)
xml_doc.xpath('//checkstyle/file').each do |f|
    f.xpath('//error').each do |e|
         e['line']

         location = CCEngine::Location::LineRange.new(
             path:       f['name'],
             line_range: e['line'].to_i..e['line'].to_i
         )

         issue = CCEngine::Issue.new(
             check_name:  e['severity'],
             description: e['message'],
             categories:  [CCEngine::Category.style],
             location:    location
         )

         puts issue.render
    end
end

