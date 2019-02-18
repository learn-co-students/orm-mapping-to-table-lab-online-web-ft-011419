class Student

attr_accessor :name, :grade
attr_reader :id

@@all = []

def initialize(name, grade)
  @name = name
  @grade = grade
end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

def self.create_table
  DB[:conn].execute("CREATE TABLE students
  (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)")
end
  
def self.drop_table
  DB[:conn].execute("DROP TABLE students")
end

def save
  sql= <<-SQL
  INSERT INTO students (name, grade) VALUES (?,?)
  SQL
  
  DB[:conn].execute(sql, self.name, self.grade)
  @id = DB[:conn].execute("SELECT id FROM students WHERE id = (SELECT (id) FROM students);")[0][0]
end


def self.create(student)
  student = self.new(student[:name], student[:grade])
  student.save
  student
end
  







end