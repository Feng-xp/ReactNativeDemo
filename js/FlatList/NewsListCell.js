'use strict';

import React from 'react';
import {
	StyleSheet,
	View,
	Text,
	FlatList,
	Image
} from 'react-native';

class NewsListCell extends React.Component {
	render() {
		const item = this.props.item;
		return (
			<View style={styles.cell}>
				<Image style={styles.imgAvatar} source={{uri:'http://facebook.github.io/react/img/logo_og.png'}}/>
				<View style={styles.titleContainer}>
					<Text style={styles.title}>{item.key}</Text>
					<Text numberOfLines={1} style={styles.subtitle}>我是一只小消息小小小小鸟，想要飞啊飞却怎么也飞不高</Text>
				</View>
			</View>
		);
	}
}

var styles = StyleSheet.create({
	cell: {
		height: 80,
		flexDirection: 'row',
		alignItems: 'center',
		backgroundColor: 'white',
	},
	imgAvatar: {
		width: 60,
		height: 60,
		borderRadius: 30,
		marginLeft: 15
	},
	titleContainer: {
		height: 60,
		justifyContent: 'space-between',
		position: 'absolute',
		left: 85,
		right: 15
	},
	title: {
		paddingTop: 10
	},
	subtitle: {
		paddingBottom: 10,
	}
});

// Module name
export default NewsListCell;