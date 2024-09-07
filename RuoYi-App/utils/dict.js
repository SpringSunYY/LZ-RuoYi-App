import {getDicts} from "@/api/system/dict/data";

// 公共方法，用于处理字典数组
export async function getDict(dict) {
    try {
        const res = await getDicts(dict); // 等待异步请求完成
        const tempDict = res.data;
        if (tempDict.length > 0) {
            const newDicts = tempDict.map((item) => {
                return {
                    raw: item,
                    label: item.dictLabel,
                    value: item.dictValue
                };
            });
            return newDicts; // 正确返回处理后的数组
        }
        return []; // 如果数组为空，返回空数组
    } catch (error) {
        console.error('Error fetching dicts:', error);
        return []; // 处理异常情况下的返回值
    }
}

export async function getSelectDict(dict) {
    try {
        const res = await getDicts(dict); // 等待异步请求完成
        const tempDict = res.data;
        if (tempDict.length > 0) {
            const newDicts = tempDict.map((item) => {
                return {
                    text: item.dictLabel,
                    value: item.dictValue
                };
            });
            return newDicts; // 正确返回处理后的数组
        }
        return []; // 如果数组为空，返回空数组
    } catch (error) {
        console.error('Error fetching dicts:', error);
        return []; // 处理异常情况下的返回值
    }
}
