shinyServer(function(session, input, output){

    ##================= Control Terminology Tab: Show summary results  =========================================================================================================================================================================================================================###
    observe({
        EXTRA101 <- termData$version[termData$origin==input$IN101]
        updateSelectInput(session, "IN102","NCI-EVS Published Date",choices = rev(sort(unique(EXTRA101))))
        })

    observe({    
        EXTRA102 <- termData$p.cdsubval[termData$verdate == input$IN102 & termData$origin ==input$IN101]
        updateSelectInput(session, "IN103","CDISC Codelist Name",choices = sort(unique(EXTRA102)))
      })
    
    output$TAB.B101 <- renderText({
        OUT101 <- paste0("CDISC Standard : ",input$IN101)
    })
    
    output$TAB.B102 <- renderText({
        OUT102 <- paste0("NCI-EVS Published Date : ",input$IN102)
    })

    
    output$TAB.B103 <- renderText({
        OUT103 <- paste0("NCI Code Name : ",termData %>% filter(origin %in% input$IN101 & p.cdsubval %in% input$IN103 & verdate %in% input$IN102) %>% distinct(cp.cdlstname) %>% select(cp.cdlstname))
    })
    
    output$TAB.B104 <- renderText({
        OUT104 <- paste0("NCI Code : ",termData %>% filter(origin %in% input$IN101 & p.cdsubval %in% input$IN103 & verdate %in% input$IN102) %>% distinct(cdlstcd) %>% select (cdlstcd))
    })
    
    output$TAB.B105 <- renderText({
        OUT105 <- paste0(termData %>% filter(origin %in% input$IN101 & p.cdsubval %in% input$IN103 & verdate %in% input$IN102) %>% distinct(extyn) %>% select(extyn))
    })
    
    output$TAB.B106 <- renderText({
        OUT106 <- paste0("The server has been updated on : ", termData %>% filter(origin %in% input$IN101 & p.cdsubval %in% input$IN103 & verdate %in% input$IN102) %>% distinct(last.update) %>% select(last.update))
    })
    
    ##============ Control Terminology Tab: For Select input word search =====================================#
    
    output$TAB.B107 <- renderDataTable({
        OUT107 <- termData %>% filter(origin %in% input$IN101 & p.cdsubval %in% input$IN103 & verdate %in% input$IN102) %>% select(Code,c.cdsubval,c.cdsyno,c.cddef,c.ncipt) %>% rename(CodeList.Name=c.cdsubval,
                                                                                                                                                                                  CDISC.Synonym=c.cdsyno,
                                                                                                                                                                                  CDISC.Definition=c.cddef,
                                                                                                                                                                                  NCI.Prefered.Term=c.ncipt)    
    },options = list(lengthMenu = list(c(5,10,25,50,-1), c('5', '10','25','50','All')), searching = T, pageLength = 25,
                     language = list(zeroRecords = "Server is ready to receive requests"), 
                     smart = TRUE,
                     searchHighlight = TRUE, search = list(search = ''),
                     columnDefs = list(list(width = "800px", targets = c(4,5))),
                     initComplete = JS("
                  function(settings, json) {
                    $(this.api().table().header()).css({
                      'background-color': '#0a0000',
                      'color': '#fff'
                    });
    }")))
    
    ##================= Implementation Guide =========================================================================================================================================================================================================================###
    observe({
      EXTRA201 <- alligdata$version[alligdata$origin==input$IN201]
      updateSelectInput(session, "IN202","CDISC Version",choices = rev(sort(unique(EXTRA201))))
    })
    
    observe({    
      EXTRA202 <- alligdata$dataset[alligdata$version == input$IN202 & alligdata$origin ==input$IN201]
      updateSelectInput(session, "IN203","CDISC Codelist Name",choices = sort(unique(EXTRA202)))
    })
    
    output$TAB.B201 <- renderText({
      OUT201 <- paste0("CDISC Standard : ",input$IN201)
    })
    
    output$TAB.B202 <- renderText({
      OUT202 <- paste0("CDISC Version : ",input$IN202)
    })
    
    output$TAB.B203 <- renderText({
      OUT203 <- paste0("Dataset Name : ",alligdata %>% filter(origin %in% input$IN201 & dataset %in% input$IN203 & version %in% input$IN202) %>% distinct(parentDataset.title) %>% select(parentDataset.title))
    })
    
    output$TAB.B204 <- renderText({
      OUT204 <- paste0("Structure : ",alligdata %>% filter(origin %in% input$IN201 & dataset %in% input$IN203 & version %in% input$IN202) %>% distinct(datasetStructure) %>% select(datasetStructure))
    })
    
    output$TAB.B205 <- renderText({
      OUT205 <- paste0("The server has been updated on : ", alligdata %>% filter(origin %in% input$IN201 & dataset %in% input$IN203 & version %in% input$IN202) %>% distinct(last.update) %>% select(last.update))
    })
    
    ##============ Control Terminology Tab: For Select input word search =====================================#
    
    output$TAB.B206 <- renderDataTable({
        OUT206 <- alligdata %>% filter(origin %in% input$IN201 & dataset %in% input$IN203 & version %in% input$IN202) %>% select(name,label,role,core,codelist,simpleDatatype,description) %>% rename(Data.Type=simpleDatatype,Full.Description = description) 
    },options = list(lengthMenu = list(c(5,10,25,50,-1), c('5', '10','25','50','All')), searching = T, pageLength = 10,
                     language = list(zeroRecords = "Server is ready to receive requests"), 
                     smart = TRUE,
                     searchHighlight = TRUE, search = list(search = ''),
                     columnDefs = list(list(width = "65px", targets = c(1:6))),
                     initComplete = JS("
                  function(settings, json) {
                    $(this.api().table().header()).css({
                      'background-color': '#0a0000',
                      'color': '#fff'
                    });
    }")))
    
})
