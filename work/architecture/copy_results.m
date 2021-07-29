function obj1 = copy_results(obj1, obj2)
    obj1.done = obj2.done;
    obj1.time_done = obj2.time_done;
    obj1.data = obj2.data;
    obj1.result = obj2.result;
end