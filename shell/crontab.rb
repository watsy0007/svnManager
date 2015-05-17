require 'open-uri'
require 'json'

BASEURI = 'http://localhost:3000/'
SVNPATH = '/home/svnroot/repository'
USER = 'wangyan'
PASSWORD = 'wangyan'

def processSVN
	uri = BASEURI + 'projects.json'
	http_response = nil

	open(uri) do |http|
		http_response = http.read
	end 	
	if http_response
		data = JSON.parse(http_response)
		if data
			data.each do |project|
				uri = BASEURI + 'projects/' + project['id'].to_s + '.json'
				open(uri, :http_basic_authentication => [USER, PASSWORD]) do |projectHttp|
					jsonData = JSON.parse(projectHttp.read)
					if jsonData
						path = SVNPATH + jsonData['path'] + '/conf/passwd'
						writeSVNFile(path, jsonData['projectusers'])
					end
				end		
			end
		end
	end	
end

def writeSVNFile(path, data)
	if File.exist?(path)
		file = File.new(path, "w")
		if file
			file.puts '[users]'
			data.each do |user|
				file.puts user['name'] + '=' + user['password']
			end
		end
	end
	puts path, data
end

processSVN

# writeSVNFile '/Users/watsy/Desktop/1.txt', [{'name' => 'wangyan', 'password' => '123456'}, {'name' => 'admin', 'password' => '123456'}]