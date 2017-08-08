import React from 'react';
import ListItem from './ListItem.jsx';

const List = (props) => (
  <div>
    <h4> Accounts </h4>
    Total { props.items.length } clients insured.
    { props.items.map(item => <ListItem item={item}/>)}
  </div>
)

export default List;