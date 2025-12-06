{ ... }:

{
  name = "thrpm";
  language = "python";

  script = ''
    import sys
    from PySide6.QtWidgets import QApplication, QMainWindow
    from PySide6.QtWebEngineWidgets import QWebEngineView
    from PySide6.QtCore import Qt

    app = QApplication(sys.argv)

    # Create main window
    window = QMainWindow()
    window.setWindowTitle("Pomofocus Mini")
    window.setMinimumSize(400, 180)  # Non-resizable window
    window.setMaximumSize(400, 800)  # Non-resizable window
    window.resize(400, 180)  # Non-resizable window

    # Create a web view and load Pomofocus
    browser = QWebEngineView()
    browser.setUrl("https://pomofocus.io/")

    # Remove the maximize button (optional)
    window.setWindowFlags(window.windowFlags() & ~
                          Qt.WindowType.WindowMaximizeButtonHint)

    # Set browser as central widget
    window.setCentralWidget(browser)

    window.show()
    sys.exit(app.exec())
  '';
}
