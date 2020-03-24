require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
set :database, { adapter: "sqlite3", database: "mydb.db" }
require './models/student'
require './models/college_class'
require './models/student_class'

# get '/' do
#     Student.all.to_yaml + CollegeClass.all.to_yaml + StudentClass.all.to_yaml
# end

get '/' do
    @students = Student.all
    @classes = CollegeClass.all
    erb :home 
end
    
post '/find_student' do
    @student = Student.find_by(name: params[:name])
    erb :student
end
    
post '/find_class' do
    @class = CollegeClass.find_by(name: params[:name])
    @students = @class.students
    # @students = []
    # if sc.college_class == @class
    #     @students << @student.name
    # end
    erb :class
end

get '/students' do
    @students = Student.all
    erb :students
end

get '/student/:id' do
    @student = Student.find(params[:id])
    if @student.nil?
        return "student not found"
    end
    erb :student
end

get '/show_student' do
    @student = Student.find(params[:id])
    @classes = Student.college_classes
    erb :show_student
end

get 'classes' do
    @classes = CollegeClass.all
    erb :classes
end

get '/class/:id' do
    @class = CollegeClass.find(params[:id])
    if @class.nil?
        return "class not found"
    end
    erb :class

post '/show_class' do
    @class = CollegeClass.find(params[:id])
    @students = @class.students
    erb :show_class
end
