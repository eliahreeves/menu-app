import json

def read_json(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)

def compare_dicts(dict1, dict2):
    differences = {}

    def compare_nested(d1, d2, path=''):
        all_keys = set(d1.keys()).union(set(d2.keys()))
        for key in all_keys:
            new_path = f"{path}.{key}" if path else key
            if isinstance(d1.get(key), dict) and isinstance(d2.get(key), dict):
                compare_nested(d1.get(key, {}), d2.get(key, {}), new_path)
            elif isinstance(d1.get(key), list) and isinstance(d2.get(key), list):
                if not compare_lists(d1.get(key), d2.get(key)):
                    differences[new_path] = {'menu1': d1.get(key), 'menu2': d2.get(key)}
            elif d1.get(key) != d2.get(key):
                differences[new_path] = {'menu1': d1.get(key), 'menu2': d2.get(key)}

    def compare_lists(list1, list2):
        if len(list1) != len(list2):
            return False
        for item1, item2 in zip(sorted(list1, key=str), sorted(list2, key=str)):
            if isinstance(item1, dict) and isinstance(item2, dict):
                if compare_dicts(item1, item2):
                    return False
            elif item1 != item2:
                return False
        return True

    compare_nested(dict1, dict2)
    return differences

def main():
    dict1 = read_json('menu1.json')
    dict2 = read_json('menu2.json')
    differences = compare_dicts(dict1, dict2)
    with open('differences.json', 'w') as file:
        json.dump(differences, file, indent=4)

if __name__ == "__main__":
    main()
