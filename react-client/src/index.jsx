import React from 'react';
import ReactDOM from 'react-dom';
import $ from 'jquery';
import List from './components/List.jsx';
import axios from 'axios';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { 
      items: fakeData
    }
  }

  componentDidMount() {
    axios.get('/accounts')
      .then((res) => {
        console.log(res);
        this.setState({
          items: res.data
        })
      })
      .catch(function (err) {
        console.log(err);
      });
  }

  render () {
    return (<div>
      <h1>Policy Overview</h1>
      <List items={this.state.items}/>
    </div>)
  }
}

window.fakeData = [
{
  account: '0xbab8be5abff53ae3e45b0e75d3e8719e6f9b1145',
  balance: 10
},
{
  account: '0xffcc7a83cc4d4bd487e7d7bcfb8b666f79f2077e',
  balance: 25
},
{
  account: '0x6dbdffec2988fd589a3a059e05be989765ae401b',
  balance: 33
}
];


ReactDOM.render(<App />, document.getElementById('app'));