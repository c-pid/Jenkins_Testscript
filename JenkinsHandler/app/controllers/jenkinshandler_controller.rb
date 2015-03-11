class JenkinshandlerController < ApplicationController
require 'json'
require 'jenkins_api_client'

	def index
	end
	
	def show
	end
	
	def new
	end
	
	def edit
	end
	
	def create
		testcase_input = testcase_params
		testcase_input["time_last_run"] = DateTime.now
		testcase_input["state"] = "PASSED"
		testcase_input["test_type"] = 2
		@testcase = Testcase.new(testcase_input)
 
		if @testcase.save
			redirect_to testcases_path
		else
			
		end
	end
	
	def update
		@testcase = Testcase.find(params[:id])
		testcase_input = testcase_params
		testcase_input["time_last_run"] = DateTime.now
		testcase_input["state"] = "PASSED"
		testcase_input["test_type"] = 1
		 @testcase = Testcase.new(testcase_input)
 
		if @testcase.update(testcase_input)
			redirect_to testcases_path
		else
			render 'edit'
		end
	end
	
	def destroy
		@testcase = Testcase.find(params[:id])
		@testcase.destroy
 
		redirect_to testcases_path
	end
	
	def updatecases
		testcase_parse
		redirect_to testcases_path
	
	end
	
	private
		def testcase_parse
			client = JenkinsApi::Client.new(:server_ip => '52.16.157.73', :server_port => '80',:jenkins_path => '/jenkins/',
         :username => 'user', :password => 'IXutnKRARd1x')
         
         current_build = client.job.get_current_build_number('Test')

		test_result = client.job.get_test_results('Test',current_build)
		
		tests = test_result["childReports"]
		cases = tests[0]["result"]["suites"][0]["cases"]
		puts cases
		
				for testcase in cases do 
					testcase_input = {}
					testcase_input["name"] = testcase["name"]
					testcase_input["path"] = testcase["className"]
					testcase_input["state"] = testcase["status"]
					testcase_input["test_type"] = 2
					testcase_input["time_last_run"] = DateTime.now
					
					testcaseObject = Testcase.new(testcase_input)
					
					testcaseObject.save
				end

		

		
		
		end
end
