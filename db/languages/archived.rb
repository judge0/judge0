@languages ||= []
@languages +=
[
    {
        id: 16,
        name: "C# (.NET Core SDK 3.1.302)",
        is_archived: true,
        source_file: "Main.cs",
        compile_cmd: "cp /files/c#-dotnet/* . && mkdir -p ~/.dotnet && touch ~/.dotnet/3.1.302.dotnetFirstUseSentinel && /usr/bin/dotnet build %s Main.csproj",
        run_cmd: "/usr/bin/dotnet run --no-build Main.csproj %s"
      },
      {
        id: 17,
        name: "C# (Mono 6.10.0.104)",
        is_archived: true,
        source_file: "Main.cs",
        compile_cmd: "/usr/bin/mcs %s Main.cs",
        run_cmd: "/usr/bin/mono Main.exe %s"
      },
      {
        id: 18,
        name: "C# Test (.NET Core SDK 3.1.302, NUnit 3.12.0)",
        is_archived: true,
        source_file: "Test.cs",
        compile_cmd: "cp /files/nunit/* . && mkdir -p ~/.dotnet && touch ~/.dotnet/3.1.302.dotnetFirstUseSentinel && dotnet restore --source /NuGet/packages && dotnet build --no-restore %s Test.csproj",
        run_cmd: "/usr/bin/dotnet test --no-build Test.csproj %s"
      },
      {
        id: 19,
        name: "F# (.NET Core SDK 3.1.302)",
        is_archived: true,
        source_file: "script.fsx",
        run_cmd: "mkdir -p ~/.dotnet && touch ~/.dotnet/3.1.302.dotnetFirstUseSentinel && /usr/bin/dotnet fsi script.fsx %s"
      }
]