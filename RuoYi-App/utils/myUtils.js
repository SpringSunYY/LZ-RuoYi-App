/**
 * 组装符合下拉框复选框等的字典数据
 * @param options 原始字典数组
 * @param valueAttr 原始字典数组中value的属性名称
 * @param labelAttr 原始字典数组中label的属性名称
 */
export function getDictOption(options, valueAttr, labelAttr) {
	const arr = [];
	for (var i = 0; i < options.length; i++) {
		var json = {};
		var dict = options[i];
		json['value'] = dict[valueAttr];
		json['text'] = dict[labelAttr];
		arr[i] = json;
	}
	return arr
}

/**
 * 查询参数增加日期范围查询
 * @param queryParams 筛选条件的json数据
 * @param screenResult 筛选条件的日期范围
 */
export function addDateRange(queryParams, screenResult, ) {
	var params = {};
	params['beginCreateTime'] = screenResult['beginCreateTime'];
	params['endCreateTime'] = screenResult['endCreateTime'];
	queryParams['params'] = params;
	return queryParams
}
/* 上传文件开始 */
/**
 * 编辑时组装上传文件数据的回显
 * @param baseUrl 文件访问的服务器地址，例如127.0.0.1:18100
 * @param columnUrls 上传文件的以逗号分隔的多个url地址
 * @param columnFileIds 上传文件的以逗号分隔的多个fileId
 * @param columnFileLists 上传文件回显的文件数组
 */
export function editUploadEcho(baseUrl, columnUrls, columnFileIds, columnFileLists) {
	let columnUrlArr = columnUrls.split(",");
	let columnFileIdArr = columnFileIds.split(",");
	for (var i = 0; i < columnUrlArr.length; i++) {
		var columnUrl = columnUrlArr[i]
		var columnJson = {};
		columnJson['url'] = baseUrl + columnUrl;
		columnJson['extname'] = columnUrl.substr(columnUrl.lastIndexOf(".") + 1, columnUrl.length);
		columnJson['name'] = columnUrl.substr(columnUrl.lastIndexOf("/") + 1, columnUrl.length);
		columnJson['fileId'] = columnFileIdArr[i]
		columnFileLists.push(columnJson)
	}
	return columnFileLists
}

/**
 * 编辑时删除文件
 * @param columnFileIds 以逗号分隔的多个fileId
 * @param toDeleteFileId 将要删除文件的fileId
 */
export function editUploadDelete(columnFileIds, toDeleteFileId) {
	var arr = []
	var columnFileIdArr = columnFileIds.split(",")
	for (var i = 0; i < columnFileIdArr.length; i++) {
		if (columnFileIdArr[i] != toDeleteFileId) {
			arr.push(columnFileIdArr[i])
		}
	}
	columnFileIds = arr.join(",");
	return columnFileIds
}


/**
 * 新增时组装上传文件数据
 * @param response 接口响应数据
 * @param columnFileId form表单绑定字段的文件id
 * @param columnFileIdTempFilePath form表单绑定字段的临时文件路径
 * @param tempFilePath 选取文件后触发上传的临时文件路径
 */
export function addUploadData(response, columnFileId, columnFileIdTempFilePath, tempFilePath) {
	console.log(response)
	if (!columnFileId) {
		columnFileId = response.fileName
		columnFileIdTempFilePath = tempFilePath
	} else {
		columnFileId = columnFileId + "," + response.fileName
		columnFileIdTempFilePath = columnFileIdTempFilePath + "," + tempFilePath
	}
	var json = {}
	json['fileId'] = columnFileId
	json['fileIdTempFilePath'] = columnFileIdTempFilePath
	return json
}


/**
 * 新增时上传文件删除操作
 * @param fileIdTempFilePath  form表单绑定字段的临时文件路径
 * @param fileId form表单绑定字段的文件id
 * @param tempFilePath 要删除文件的临时路径
 */
export function addUploadDelete(fileIdTempFilePath, fileId, tempFilePath) {
	var arr = []
	var fileIdTempFilePathArr = fileIdTempFilePath.split(",")
	var fileIdArr = fileId.split(",")
	for (var i = 0; i < fileIdTempFilePathArr.length; i++) {
		if (fileIdTempFilePathArr[i] != tempFilePath) {
			arr.push(fileIdArr[i])
		}
	}
	return arr;
}

/* 上传文件结束 */

/* 列表转为树结构开始 */
/**
 * 将列表数据字段属性转为下拉框树对应属性
 * @param options 原始字典数组
 * @param valueAttr 原始字典数组中value的属性名称
 * @param labelAttr 原始字典数组中label的属性名称
 */
export function getLabelTreeList(dataList, valueAttr, labelAttr, parentIdAttr) {
	var arr = [];
	for (var data of dataList) {
		var json = {}
		json['id'] = data[valueAttr].toString()
		json['label'] = data[labelAttr]
		json['parentId'] = data[parentIdAttr].toString()
		arr.push(json)
	}
	return arr
}

// export function integerToString(dataList,treeCode,treeName,parentTreeCode) {
// 	var arr = [];
// 	for(let data of dataList){
// 		var json = {};
// 		json[treeCode]=data[treeCode].toString();
// 		json[treeName]=data[treeName].toString();
// 		json[parentTreeCode]=data[parentTreeCode].toString();
// 		arr.push(json);
// 	}
//   return arr
// }

/**
 * 构造树型结构数据
 * @param {*} data 数据源
 * @param {*} id id字段 默认 'id'
 * @param {*} parentId 父节点字段 默认 'parentId'
 * @param {*} children 孩子节点字段 默认 'children'
 */
export function handleTree(data, id, parentId, children) {
	let config = {
		id: id || 'id',
		parentId: parentId || 'parentId',
		childrenList: children || 'children'
	};

	var childrenListMap = {};
	var nodeIds = {};
	var tree = [];

	for (let d of data) {
		let parentId = d[config.parentId];
		if (childrenListMap[parentId] == null) {
			childrenListMap[parentId] = [];
		}
		nodeIds[d[config.id]] = d;
		childrenListMap[parentId].push(d);
	}

	for (let d of data) {
		let parentId = d[config.parentId];
		if (nodeIds[parentId] == null) {
			tree.push(d);
		}
	}

	for (let t of tree) {
		adaptToChildrenList(t);
	}

	function adaptToChildrenList(o) {
		if (childrenListMap[o[config.id]] !== null) {
			o[config.childrenList] = childrenListMap[o[config.id]];
		}
		if (o[config.childrenList]) {
			for (let c of o[config.childrenList]) {
				adaptToChildrenList(c);
			}
		}
	}
	return tree;
}
/* 列表转为树结构结束 */

/* int型数组转为字符串数组 */
export function intArrayToString(integerArr) {
	var stringArr = [];
	for (let arr of integerArr) {
		stringArr.push("'" + arr + "'")
	}
	return stringArr;
}
