# Wednesday June 19 2024

Started implementing logs and context propagation for *adamastor*.  
There were the following problems, when setting the context in the PersistentPreRun variable, this context does not correspond to the context of the command.
The context needs to be created before the cmd variable in order to be passed both to the config and set in the command itself:
```
func RootCmd() *cobra.Command {
	ctx := context.Background()
	cmd := cobra.Command{
		Use:   "adamastor",
		Short: "Go Framework",
		Long:  "Scrapes the web, scrapes my patience",
		PersistentPreRun: func(_ *cobra.Command, _ []string) {
			config.InitConfig(ctx)
			logger.SetupLogger(viper.GetString("adamastor.logLevel"))
		},
	}
	cmd.SetContext(ctx)

	cmd.AddCommand(GenerateCmd(cmd.Context()))

	return &cmd
}
```

Trying to create and customize the logger is in progress, the following sites have information on it:
(Logging in Go with Slog: The Ultimate Guide)[https://betterstack.com/community/guides/logging/logging-in-go/#creating-and-using-child-loggers]  
(Go Slog Package)[https://www.gopherguides.com/articles/golang-slog-package]
(About Structured Logging in Go 1.21)[https://lukas.zapletalovi.com/posts/2023/about-structured-logging-in-go121/]
(Creating a pretty console logger using Go's slog package)[https://dusted.codes/creating-a-pretty-console-logger-using-gos-slog-package]
