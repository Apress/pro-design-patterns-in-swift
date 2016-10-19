let search = SearchTool(dataSources: SalesDataSource(),
    DevelopmentDataSource(), NewCoDirectoryAdapter());

println("--List--");
for e in search.employees {
    println("Name: \(e.name)");
}

println("--Search--");
for e in search.search("VP", type: SearchTool.SearchType.TITLE) {
    println("Name: \(e.name), Title: \(e.title)");
}
