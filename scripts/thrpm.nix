{ pkgs, lib, ... }:

{
  name = "thrpm";
  language = "python";

  script = ''
  import sys
  import subprocess

  from PySide6.QtWidgets import (QApplication, QWidget, QVBoxLayout,
                                 QHBoxLayout, QSpinBox, QLabel, QPushButton)
  from PySide6.QtCore import QTimer, Qt
  from PySide6.QtGui import QFont


  class TimerApp(QWidget):
      def __init__(self):
          super().__init__()
          self.remaining = 0
          self.total = 0
          self.init_ui()

      def init_ui(self):
          self.setWindowTitle('Timer')
          self.setFixedSize(300, 110)

          # Simple pastel stylesheet
          self.setStyleSheet("""
              QWidget {
                  background-color: #F6F5F2;
                  color: #2A2A2E;
                  font-family: 'FiraCode Sans', Arial, sans-serif;
              }

              QSpinBox {
                  opacity: 0.7;
                  border: 1px solid #d4c5e2;
                  border-radius: 5px;
                  padding: 5px;
                  font-size: 11px;
                  text-align: center;
              }

              QSpinBox::up-button, QSpinBox::down-button {
                  opacity: 0;
                  border: none;
              }
              
              QPushButton {
                  background-color: #FF6B4E;
                  border: none;
                  border-radius: 6px;
                  padding: 8px;
                  font-size: 11px;
              }

              QPushButton:hover {
                  background-color: #E05439;
              }

              QPushButton:disabled {
                  background-color: #C9BFB9;
              }

              QLabel {
                  background-color: transparent;
              }
          """)

          # Main layout
          layout = QVBoxLayout()
          layout.setSpacing(0)
          layout.setContentsMargins(10, 10, 10, 10)

          # Display label
          self.display = QLabel('00:00')
          self.display.setAlignment(Qt.AlignCenter)
          font = QFont()
          font.setPointSize(32)
          font.setBold(True)
          self.display.setFont(font)

          control_layout = QHBoxLayout()
          control_layout.setSpacing(8)

          self.minutes_spin = QSpinBox()
          self.minutes_spin.setRange(1, 960)
          self.minutes_spin.setValue(5)
          self.minutes_spin.setSuffix(' min')
          self.minutes_spin.setFixedWidth(170)
          self.minutes_spin.setAlignment(Qt.AlignCenter)

          self.start_btn = QPushButton('')
          self.start_btn.clicked.connect(self.start_timer)

          self.skip_btn = QPushButton(' ')
          self.skip_btn.clicked.connect(self.skip_timer)
          self.skip_btn.setEnabled(False)

          self.stop_btn = QPushButton('')
          self.stop_btn.clicked.connect(self.stop_timer)
          self.stop_btn.setEnabled(False)

          control_layout.addWidget(self.minutes_spin)
          control_layout.addWidget(self.start_btn)
          control_layout.addWidget(self.stop_btn)
          control_layout.addWidget(self.skip_btn)

          # Add to main layout
          layout.addWidget(self.display)
          layout.addLayout(control_layout)

          self.setLayout(layout)

          # Timer
          self.timer = QTimer()
          self.timer.timeout.connect(self.update_timer)

          # Window flags to keep on top
          self.setWindowFlags(Qt.WindowStaysOnTopHint)

      def start_timer(self):
          if self.remaining == 0:
              minutes = self.minutes_spin.value()
              seconds = 0
              self.total = minutes * 60 + seconds

              if self.total <= 0:
                  return

              self.remaining = self.total

          self.update_display()

          self.timer.start(1000)
          self.start_btn.setEnabled(False)
          self.stop_btn.setEnabled(True)
          self.skip_btn.setEnabled(False)
          self.minutes_spin.setEnabled(False)

      def stop_timer(self):
          self.timer.stop()
          self.start_btn.setEnabled(True)
          self.stop_btn.setEnabled(False)
          self.skip_btn.setEnabled(True)

      def skip_timer(self):
          self.remaining = 0
          self.display.setText("00:00")
          self.skip_btn.setEnabled(False)
          self.minutes_spin.setEnabled(True)

      def update_timer(self):
          self.remaining -= 1

          if self.remaining <= 0:
              self.timer.stop()
              self.display.setText('DONE!')
              self.start_btn.setEnabled(True)
              self.stop_btn.setEnabled(False)
              self.skip_btn.setEnabled(False)
              self.minutes_spin.setEnabled(True)
              subprocess.run(["notify-send", "Timer", "Time is up!"])

              self.activateWindow()
              self.raise_()
          else:
              self.update_display()

      def update_display(self):
          hours = self.remaining // (60*60)
          mins = (self.remaining % (60*60)) // 60
          secs = (self.remaining % (60*60)) % 60
          if (hours > 0):
              self.display.setText(f'{hours:02d}:{mins:02d}:{secs:02d}')
          else:
              self.display.setText(f'{mins:02d}:{secs:02d}')


  if __name__ == '__main__':
      app = QApplication(sys.argv)
      timer_app = TimerApp()
      timer_app.show()
      sys.exit(app.exec())
  '';
}
