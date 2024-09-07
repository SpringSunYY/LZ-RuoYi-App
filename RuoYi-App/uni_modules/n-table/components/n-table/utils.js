// 获取数字
const getSortVal = function(val) {
	if (!val) return val;
	if (typeof val == "number") return val;
	if (typeof val == "string") {
		let str = val.replace(/,/g, "");
		let isPre = str.indexOf("%") >= 0; // 百分比单位
		let result;
		if (isPre) {
			let nb = str.split("%");
			result = nb[0];
		} else {
			if (!isNaN(Number(str))) return Number(str);
			let arrr = str.match(/\d+(.\d+)?/g);
			if (arrr && arrr.length) result = arrr[0];
		}
		result = Number(result);
		let notNumber = isNaN(Number(result));
		if (notNumber) return 0;
		return result;
	}
	return val;
};


// 排序
const sortList = function({ list, sortBy, sortOrder, child = "children" }) {
	if (!sortBy || !sortOrder) return list;
	child &&
		list.length &&
		list.forEach(item => {
			if (item[child] && item[child].length) {
				item[child] = sortList({
					list: item[child],
					sortBy: sortBy,
					sortOrder: sortOrder,
					child: child,
				});
			}
		});
	list.sort((a, b) => {
		return sortOrder.toLowerCase() == "asc" ? getSortVal(a[sortBy] || 0) - getSortVal(b[sortBy] || 0) :
			getSortVal(b[sortBy] || 0) - getSortVal(a[sortBy] || 0);
	});
	return [...list];
};

export {
	sortList
}
