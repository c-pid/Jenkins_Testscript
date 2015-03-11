#!/usr/local/bin/ruby 
require 'jenkins_api_client'


@client = JenkinsApi::Client.new(:server_ip => '52.16.157.73', :server_port => '80',:jenkins_path => '/jenkins/',
         :username => 'user', :password => 'IXutnKRARd1x')
         
         
 jobs = @client.job.list_all()

current_build = @client.job.get_current_build_number('Test')

test_result = @client.job.get_test_results('Test',current_build)

string = "/job/Test/2/test$test/testReport/test.test/Hello_WorldTest/testHelloWorld"

test_detail = @client.api_get_request(string)

puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
puts jobs
puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
puts current_build
puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
puts test_result
puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
puts test_detail
puts "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
