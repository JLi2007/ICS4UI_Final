/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */
synchronized public void draw_toolbarWindow(PApplet appc, GWinData data) { //_CODE_:toolbarWindow:990813:
    appc.background(230);
    appc.fill(196, 196, 196);
    appc.stroke(196, 196, 196);
    appc.rect(0, 260, 400, 200);
    appc.fill(13, 1, 115);
    appc.stroke(13, 1, 115);
    appc.textSize(18);

    // if statements to determine what to display on status    
    if(successStatus){
      appc.fill(23, 163, 2);
      appc.text("✓ STATUS ✓", 170, 280);
    } 
    else{
      appc.fill(199, 8, 21);
      appc.text("x STATUS x", 170, 280);
    }

    statusDescription = new GTextArea(toolbarWindow, 10, 290, 380, 50, G4P.SCROLLBARS_NONE);
    statusDescription.setText("Welcome to Euronodes");
    statusDescription.setFont( new Font("SansSerif", Font.PLAIN, 14) );

    if(showDijkstra){
      statusDescription.setText(endingCity + " is " + dijkstraArray[endingIndex] + " units (" + normalizeDistance(dijkstraArray[endingIndex]) + "km) away from " + startingCity);
    }
    else if(addEdgeStatus.equals("F")){
      statusDescription.setText("CANNOT add edge, country name(s) spelled wrong or the node does not exist on the map");
    }
    else if(addEdgeStatus.equals("S")){
      statusDescription.setText("Added edge from " + addedEdge1.toUpperCase() + " to " + addedEdge2.toUpperCase());
    }
} //_CODE_:toolbarWindow:990813:

synchronized public void draw_infoWindow(PApplet appc, GWinData data) {
    appc.background(230);
    appc.fill(0);

    if(showCountryInfo && selectedCountry != null){
        appc.text(selectedCountry, 10, 20);
    }
    else{
        appc.text("Select a country on the UI to display information", 10, 20);
    }
}

public void edgesChecked(GCheckbox source, GEvent event) { //_CODE_:edgesCheck:657761:
  showEdges = !showEdges;
} //_CODE_:edgesCheck:657761:

public void edgeDistChecked(GCheckbox source, GEvent event) { //_CODE_:edgesCheck:657761:
  showEdgeDist = !showEdgeDist;
} //_CODE_:edgesCheck:657761:

public void selectStartingCountry(GDropList source, GEvent event) { //_CODE_:Starting:463717:
  showDijkstra = false;
  startingCountry = returnCountry(startingSelect.getSelectedText());
  startingCity = returnCity(startingSelect.getSelectedText());
} //_CODE_:Starting:463717:

public void selectEndingCountry(GDropList source, GEvent event) { //_CODE_:Starting:463717:
  showDijkstra = false;
  endingCountry = returnCountry(endingSelect.getSelectedText());
  endingCity = returnCity(endingSelect.getSelectedText());
} //_CODE_:Starting:463717:

public void selectPassingCountry(GDropList source, GEvent event) { //_CODE_:Starting:463717:
  //todo

} //_CODE_:Starting:463717:

public void inputEdge1(GTextField source, GEvent event) { //_CODE_:textfield1:655026:
  addedEdge1 = addEdge1.getText();
} //_CODE_:textfield1:655026:

public void inputEdge2(GTextField source, GEvent event) { //_CODE_:textfield1:655026:
  addedEdge2 = addEdge2.getText();
} //_CODE_:textfield1:655026:

public void addEdge(GButton source, GEvent event) { //_CODE_:dijkstra_btn:278201:
  showDijkstra = false;

  // add the edge if the user inputs are correct
  if(returnNodeWithName(addedEdge1) != null && returnNodeWithName(addedEdge2) != null ){
    Node n1 = returnNodeWithName(addedEdge1);
    Node n2 = returnNodeWithName(addedEdge2);
    n1.borderingCountries.put(n2.country, n1.calculateDistance(n1,n2));
    n2.borderingCountries.put(n1.country, n2.calculateDistance(n2,n1));
    n1.createEdges(false);
    n2.createEdges(false);
    // display success message in STATUS
    successStatus = true;
    addEdgeStatus = "S";
  }
  // otherwise, display the failure message in STATUS
  else{
    successStatus = false;
    addEdgeStatus = "F";
  }
} //_CODE_:dijkstra_btn:278201:

public void initDijkstra(GButton source, GEvent event) { //_CODE_:dijkstra_btn:278201:
  if(startingCountry != null){
    dijkstraArray = runDijkstra(returnNodeWithName(startingCountry));

    // placeholder
    printArray(dijkstraArray);
    println("ran dijkstra and populated array var");

    endingIndex = returnNodePosition(returnNodeWithName(endingCountry));

    println(endingCountry + " is " + dijkstraArray[endingIndex] + " units away from " + startingCountry);
    successStatus = true;
    showDijkstra = true;
    addEdgeStatus = "N";
  }
} //_CODE_:dijkstra_btn:278201:

// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Euro•Nodes");

  toolbarWindow = GWindow.getWindow(this, "Toolbar", 1100, 0, 400, 350, JAVA2D);
  toolbarWindow.noLoop();
  toolbarWindow.setActionOnClose(G4P.KEEP_OPEN);
  toolbarWindow.addDrawHandler(this, "draw_toolbarWindow");
  toolbarWindow.loop();

  infoWindow = GWindow.getWindow(this, "Information", 1100, 450, 400, 350, JAVA2D);
  infoWindow.noLoop();
  infoWindow.setActionOnClose(G4P.KEEP_OPEN);
  infoWindow.addDrawHandler(this, "draw_infoWindow");
  infoWindow.loop();

  edgesCheck = new GCheckbox(toolbarWindow, 20, 10, 200, 50);
  edgesCheck.setFont(new Font("SansSerif", Font.PLAIN, 18));
  edgesCheck.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  edgesCheck.setText(" Show Edges -->");
  edgesCheck.setOpaque(false);
  edgesCheck.addEventHandler(this, "edgesChecked");

  edgeDistCheck = new GCheckbox(toolbarWindow, 200, 10, 200, 50);
  edgeDistCheck.setFont(new Font("SansSerif", Font.PLAIN, 18));
  edgeDistCheck.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  edgeDistCheck.setText(" Show Edge Dists");
  edgeDistCheck.setOpaque(false);
  edgeDistCheck.addEventHandler(this, "edgeDistChecked");

  startingSelect = new GDropList(toolbarWindow, 20, 90, 150, 100, 5, 10);
  startingSelect.setItems(loadStrings("list_countries"), 0);
  startingSelect.addEventHandler(this, "selectStartingCountry");
  starting_label = new GLabel(toolbarWindow, 20, 70, 150, 20);
  starting_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  starting_label.setText("Where To Start");
  starting_label.setOpaque(false);
  starting_label.setFont(new Font("SansSerif", Font.PLAIN, 14));

  endingSelect = new GDropList(toolbarWindow, 20, 140, 150, 100, 5, 10);
  endingSelect.setItems(loadStrings("list_countries"), 0);
  endingSelect.addEventHandler(this, "selectEndingCountry");
  ending_label = new GLabel(toolbarWindow, 20, 120, 150, 20);
  ending_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  ending_label.setText("Where To End");
  ending_label.setOpaque(false);
  ending_label.setFont(new Font("SansSerif", Font.PLAIN, 14));

  passingSelect = new GDropList(toolbarWindow, 20, 190, 150, 100, 5, 10);
  passingSelect.setItems(loadStrings("list_countries"), 0);
  passingSelect.addEventHandler(this, "selectPassingCountry");
  passing_label = new GLabel(toolbarWindow, 20, 170, 150, 20);
  passing_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  passing_label.setText("Where To Pass");
  passing_label.setOpaque(false);
  passing_label.setFont(new Font("SansSerif", Font.PLAIN, 14));

  dijkstra_btn = new GButton(toolbarWindow, 150, 225, 100, 30);
  dijkstra_btn.setText("Run Algo");
  dijkstra_btn.addEventHandler(this, "initDijkstra");

  adding_edge_label = new GLabel(this, 0, 600, 200, 50);
  adding_edge_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  adding_edge_label.setText("Add an edge between two countries");
  adding_edge_label.setOpaque(false);
  adding_edge_label.setFont(new Font("SansSerif", Font.PLAIN, 14));
  adding_edge_label.setLocalColorScheme(GCScheme.RED_SCHEME);
  addEdge1 = new GTextField(this, 10, 650, 120, 30, G4P.SCROLLBARS_NONE);
  addEdge1.setOpaque(true);
  addEdge1.addEventHandler(this, "inputEdge1");
  addEdge1.setLocalColorScheme(GCScheme.RED_SCHEME);
  addEdge1.setPromptText("Country 1");
  addEdge2 = new GTextField(this, 10, 700, 120, 30, G4P.SCROLLBARS_NONE);
  addEdge2.setOpaque(true);
  addEdge2.addEventHandler(this, "inputEdge2");
  addEdge2.setLocalColorScheme(GCScheme.RED_SCHEME);
  addEdge2.setPromptText("Country 2");
  add_edge_btn = new GButton(this, 140, 650, 50, 80);
  add_edge_btn.setText("Add Edge");
  add_edge_btn.addEventHandler(this, "addEdge");
  add_edge_btn.setLocalColorScheme(GCScheme.RED_SCHEME);

  // pathPanel = new GPanel(this, 352, 50, 100, 80, "Path Panel");
  // pathPanel.setCollapsed(true);
  // pathPanel.setText("...");
  // pathPanel.setOpaque(true);
  // pathPanel.addEventHandler(this, "panel1_Click1");

  // initialize variables   
  startingCountry = returnCountry(startingSelect.getSelectedText());
  startingCity = returnCity(startingSelect.getSelectedText());
  endingCountry = returnCountry(endingSelect.getSelectedText());
  endingCity = returnCity(startingSelect.getSelectedText());
}

// Variable declarations 
// autogenerated do not edit
GWindow toolbarWindow;
GWindow infoWindow;
GCheckbox edgesCheck, edgeDistCheck; 
GDropList startingSelect, endingSelect, passingSelect; 
GLabel starting_label, ending_label, passing_label, adding_edge_label; 
GButton dijkstra_btn, add_edge_btn; 
GTextField addEdge1, addEdge2;
GPanel pathPanel; 
GTextArea statusDescription;