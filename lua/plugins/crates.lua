require('crates').setup {
    text = {
        loading = "  Loading...",
        version = "  v%s",
        prerelease = "  pre%s",
        yanked = "  %s yanked",
        nomatch = "  Not found",
        upgrade = "  upgrade to v%s",
        error = "  Error fetching crate",
    },
    popup = {
        text = {
            title = " # %s ",
            version = " %s ",
            prerelease = " %s ",
            yanked = " %s yanked ",
            feature = "   %s ",
            enabled = " * %s ",
            transitive = " ~ %s ",
        },
        show_version_date = true,
    },
}
