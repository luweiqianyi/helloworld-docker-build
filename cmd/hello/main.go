package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	eg := gin.Default()
	eg.GET("/hello", func(context *gin.Context) {
		context.JSON(http.StatusOK, "Welcome to visit my website")
	})

	eg.Run(":8088")
}
