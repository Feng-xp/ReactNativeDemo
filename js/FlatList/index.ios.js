'use strict';

import React from 'react';
import {
	AppRegistry,
	StyleSheet,
	View,
	Text,
	FlatList
} from 'react-native';

import NewsListCell from './NewsListCell'

var dataSource = new Array();
for (var i = 20; i >= 0; i--) {
	dataSource.push({
		key: i
	});
}

class NewsList extends React.Component {
		render() {
				return (
						<FlatList
				data={dataSource}
				renderItem={({item}) => <NewsListCell item={item}></NewsListCell>}
				initialNumToRender = {10}
			/>
		);
	}
}

// Module name
AppRegistry.registerComponent('NewsList', () => NewsList);