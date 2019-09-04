import React from "react";
import PropTypes from "prop-types";
import axios from "axios";

import "../assets/styles/App.scss";

class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      choices: [
        {
          choice: {
            id: 1,
            name: "rock"
          }
        },
        {
          choice: {
            id: 2,
            name: "paper"
          }
        },
        {
          choice: {
            id: 3,
            name: "cutters"
          }
        },
        {
          choice: {
            id: 4,
            name: "rabbit"
          }
        },
        {
          choice: {
            id: 5,
            name: "neeeeerds, omg"
          }
        }
      ],
      message: "Messages go here."
    };
  }

  componentDidMount() {
    // TODO: use a config variable instead of hardcoding.
    axios
      .get("/api/choices")
      .then(res => {
        const choices = res.data;
        this.setState({ choices });
      })
      .catch(error => {
        this.setState({ message: error.message });
        alert(error.message);
      });
  }

  // <Message messsage={String(this.state.choices)} />
  render() {
    return (
      <div className="game">
        <Message message={this.state.message} />
        <h2>Player, make a choice to play against the Computer</h2>
        <div>{/* status */}</div>
        <div>Choose for me</div>

        <ul className="choice-list">
          <li>Rock</li>
          <li>Paper</li>
          <li>Scissors</li>
          <li>Lizard</li>
          <li>Spock</li>
          <li>{/* TODO */}</li>
        </ul>

        <Choices choices={this.state.choices} />
      </div>
    );
  }
}

class Choices extends React.Component {
  render() {
    const choices = [];

    for (const [index, value] of this.props.choices.entries()) {
      choices.push(<Choice key={index} label={value.choice.name} />);
    }

    return <ul className="choice-list">{choices}</ul>;
  }
}

class Choice extends React.Component {
  doSomething(label) {
    // this.setState({ choice: label });
    alert(label);
  }

  render() {
    return (
      <li onClick={() => this.doSomething("clicked")}>{this.props.label}</li>
    );
  }
}

class Message extends React.Component {
  render() {
    return (
      <div>
        <h3>message:</h3>
        <div>{this.props.message}</div>
      </div>
    );
  }
}

export default Game;
