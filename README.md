# Battleship Game with Smart AI

## Overview
This is an advanced implementation of the classic **Battleship** game, built in Ruby, featuring a **smart AI opponent** and dynamic gameplay mechanics. Players can enjoy a challenging and engaging experience with customizable board sizes, multiple ship types, and intelligent AI strategies.

## Features
- **Dynamic Gameplay Mechanics**:
  - Customizable board sizes for varied game experiences.
  - Different ship types with unique sizes and characteristics.
  - Real-time feedback on shots (hits, misses, and sunk ships).
- **Smart AI Opponent**:
  - Utilizes an intelligent algorithm to make strategic decisions.
  - Tracks previous hits to target and sink player ships effectively.
  - Avoids redundant or invalid shots for efficient gameplay.
- **User-Friendly Game Flow**:
  - Clear prompts and feedback for user actions.
  - Interactive shot-taking mechanics for both the player and the AI.
- **Robust Gameplay Validation**:
  - Prevents duplicate shots.
  - Ensures valid placement and targeting of ships.

## Technology
- **Language**: Ruby
- **Testing Framework**: RSpec (for comprehensive test coverage of game logic).

## Setup Instructions

### Prerequisites
- Ruby installed on your system (version 2.7 or higher recommended).
- Bundler (optional, for managing dependencies).

### Installation Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/jphill19/Battleship.git
   cd Battleship

2. Run the Game: Launch the game by executing:
     ```bash
    ruby runner.rb

# How to Play

## Start the Game:
- You will be prompted to choose a board size and place your ships.
- The AI will dynamically generate its board and ship placements.

## Gameplay Loop:
- Players and the AI take turns firing shots at each other's boards.
- Receive feedback on your shots: hits, misses, and when a ship is sunk.
- The AI uses a strategic approach, targeting areas near hits to sink your ships.

## Winning the Game:
- The first to sink all opposing ships wins!

---

# Smart AI
The AI is designed with advanced logic to simulate a challenging opponent:
- **Targeting Strategy**: Once a hit is registered, the AI narrows down possible positions to sink the ship.
- **Shot Validation**: Ensures all AI shots are valid and never repeated.
- **Dynamic Adaptation**: Adjusts its approach based on board size and ship placements.

---

# Notes

### Effort and Innovation
This project represents a significant investment of time and effort to create a balanced and intelligent game experience. The smart AI and dynamic gameplay mechanics make this a standout implementation of the Battleship game.

### Potential Updates:
- Adding multiplayer support.
- Expanding ship types with new abilities or gameplay rules.
- Enhanced visuals using a graphical interface.

---

# Acknowledgments
This project reflects my passion for game development and problem-solving. I’m proud of the dynamic mechanics and the smart AI opponent that create a fun and challenging experience. Feedback and contributions are always welcome!
  
