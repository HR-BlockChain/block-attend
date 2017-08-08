import React from 'react';

const ListItem = (props) => (
  <div>
	<li>
	  <h4><strong>{props.item.account}</strong></h4>
	  balance: {props.item.balance}
	</li>
  </div>
)

export default ListItem;