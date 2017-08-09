require 'sinatra'

class Todo
	attr_accessor :task,:done,:important,:urgent
	def initialize task
		self.task=task
		done=false
		important=false
		urgent=false
	end
end

tasks=[]
t1=Todo.new "Subah Uth"
t2=Todo.new "Khana Kha"
t3=Todo.new "So ja"

tasks<<t1
tasks<<t2
tasks<<t3

get '/' do
	data=Hash.new
	data[:send_task]=tasks
	data[:curr_time]=Time.now
	erb:index, locals:data
end
post '/add' do
	task=params["input_task"]
	new_task=Todo.new task
	tasks<<new_task
	return redirect '/'
end
post '/done' do
	tasks.each do |every_task|
		if every_task.task==params["marked_task"]
			every_task.done=!every_task.done
		end
	end
	return redirect '/'
end
post '/check' do
	marked_task=params["marked_task"]
	urg=params["urg"]
	imp=params["imp"]
	tasks.each do |every_task|
		if every_task.task==marked_task
			if urg=="urgent task"
				every_task.urgent=true
			else
				every_task.urgent=false
			end
			if imp=="important task"
				every_task.important=true
			else
				every_task.important=false
			end
		end
	end
	return redirect '/'
end