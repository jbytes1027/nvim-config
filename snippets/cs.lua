return {
    s(
        "svm",
        fmta(
            [[
                    static void Main(string[] args)
                    {
                        <>
                    }
                    ]],
            i(1)
        )
    ),
    s("cwl", fmta([[ Console.WriteLine(<>); ]], i(1))),
    s(
        "///",
        fmt(
            [[
                    /// <summary>
                    /// {}
                    /// </summary>
                    ]],
            i(1)
        )
    ),
    s("<p", fmt([[<param name="{}">{}</param>]], { i(1), i(2) })),
    s("<ex", fmt([[<exception cref="{}">{}</exception>]], { i(1), i(2) })),
    s("<ret", fmt([[<returns>{}</returns>]], i(1))),
    s("<rem", fmt([[<remarks>{}</remarks>]], i(1))),
    s(
        "[F",
        fmta(
            [[
                        [Fact]
                        public async void <>()
                        {
                            // Arrange
                            <>

                            // Act
                            <>

                            // Assert
                            <>
                        }
                ]],
            { i(1), i(2), i(3), i(4) }
        )
    ),
    s(
        "[T",
        fmta(
            [[
                        [Theory]
                        [InlineData(<>)]<>
                        public async void <>
                        {
                            // Arrange
                            <>

                            // Act
                            <>

                            // Assert
                            <>
                        }
                ]],
            { i(1), i(2), i(3), i(4), i(5), i(6) }
        )
    ),
    s(
        "occontentmigrations",
        fmta(
            [[
                        public class <>Migrations : DataMigration
                        {
                            private readonly IContentDefinitionManager _contentDefinitionManager;

                            public <>Migrations(IContentDefinitionManager contentDefinitionManager) =>>
                                _contentDefinitionManager = contentDefinitionManager;

                            public int Create()
                            {
                                <>

                                return 1;
                            }
                        }
                        ]],
            { i(1), extras.rep(1), i(2) }
        )
    ),
    s(
        "ocpartdriverfull",
        fmta(
            [[
                        public class []PartDisplayDriver : ContentPartDisplayDriver<[]Part>
                        {
                            public override IDisplayResult Display([]Part part, BuildPartDisplayContext context) =>
                                Initialize<[]PartViewModel>(
                                    GetDisplayShapeType(context), 
                                    viewModel => PopulateViewModel(part, viewModel))
                                .Location("Detail", "Content:5")
                                .Location("Summary", "Content:5");
                
                            public override IDisplayResult Edit([]Part part, BuildPartEditorContext context) =>
                                Initialize<[]PartViewModel>(
                                    GetEditorShapeType(context), 
                                    viewModel => PopulateViewModel(part, viewModel))
                                .Location("Content:5");
                
                            public override async Task<IDisplayResult> UpdateAsync([]Part part, IUpdateModel updater, UpdatePartEditorContext context)
                            {
                                var viewModel = new []PartViewModel();
                
                                await updater.TryUpdateModelAsync(viewModel, Prefix);
                
                                // Populate part from view model here.
                
                                return await EditAsync(part, context);
                            }
                
                            private static void PopulateViewModel([]Part part, []PartViewModel viewModel)
                            {
                                // Populate view model from part here.
                            }
                        }
                        ]],
            {
                i(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
                extras.rep(1),
            },
            { delimiters = "[]" }
        )
    ),
}
