languages = [
  {
    name: "Java (OpenJDK 12.0.1)",
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk12/bin/javac Main.java",
    run_cmd: "/usr/local/openjdk12/bin/java Main"
  },
  {
    name: "Java Test (OpenJDK 12.0.1, JUnit 4.12, Hamcrest 2.1)",
    source_file: "MainTest.java",
    compile_cmd: "/usr/local/openjdk12/bin/javac -cp /usr/local/junit-4.12/junit-4.12.jar:/usr/local/hamcrest-2.1/hamcrest-2.1.jar MainTest.java",
    run_cmd: "/usr/local/openjdk12/bin/java -cp .:/usr/local/junit-4.12/junit-4.12.jar:/usr/local/hamcrest-2.1/hamcrest-2.1.jar org.junit.runner.JUnitCore MainTest"
  },
  {
    name: "Java Test (OpenJDK 12.0.1, JUnit Platform Console Standalone 1.5.0)",
    source_file: "MainTest.java",
    compile_cmd: "/usr/local/openjdk12/bin/javac -cp /usr/local/junit-platform-console-standalone-1.5.0/junit-platform-console-standalone-1.5.0.jar MainTest.java",
    run_cmd: "/usr/local/openjdk12/bin/java -jar /usr/local/junit-platform-console-standalone-1.5.0/junit-platform-console-standalone-1.5.0.jar --disable-ansi-colors --disable-banner -cp . -c MainTest"
  }
]


ActiveRecord::Base.transaction do
  Language.delete_all
  languages.each_with_index do |language, index|
    Language.create(
      id: index + 1,
      name: language[:name],
      compile_cmd: language[:compile_cmd],
      run_cmd: language[:run_cmd],
      source_file: language[:source_file]
    )
  end
end
