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
  appc.fill(0);
  appc.stroke(0);
  appc.text("Status", 180, 280);
} //_CODE_:toolbarWindow:990813:

public void edgesChecked(GCheckbox source, GEvent event) { //_CODE_:edgesCheck:657761:
  showEdges = !showEdges;
} //_CODE_:edgesCheck:657761:

public void edgeDistChecked(GCheckbox source, GEvent event) { //_CODE_:edgesCheck:657761:
  showEdgeDist = !showEdgeDist;
} //_CODE_:edgesCheck:657761:

public void selectStartingCountry(GDropList source, GEvent event) { //_CODE_:Starting:463717:
  startingNode = returnCountry(startingSelect.getSelectedText());
} //_CODE_:Starting:463717:

public void selectEndingCountry(GDropList source, GEvent event) { //_CODE_:Starting:463717:
  endingNode = returnCountry(endingSelect.getSelectedText());
} //_CODE_:Starting:463717:

public void initDijkstra(GButton source, GEvent event) { //_CODE_:dijkstra_btn:278201:
  if(startingNode != null){
    dijkstraArray = runDijkstra(returnNodeWithName(startingNode));
    printArray(dijkstraArray);
    println("ran dijkstra and populated array var");
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

  startingNode = returnCountry(startingSelect.getSelectedText());
}

// Variable declarations 
// autogenerated do not edit
GWindow toolbarWindow;
GCheckbox edgesCheck, edgeDistCheck; 
GDropList startingSelect, endingSelect, passingSelect; 
GLabel starting_label, ending_label, passing_label; 
GButton dijkstra_btn; 
