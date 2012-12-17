
```python
>>> class ArchType(object):
>>>   def __init__(self,name):
>>>     self.name = name
>>>     self.hitpoints = 100
>>>  def __str__(self):
>>>     return "Hello, my name is %s and I am a %s." %  \
...     ( self.name, self.__class__.__name__ )
...
>>> class LinuxGeek(ArchType):
>>>   pass
...
>>>  dan = LinuxGeek('dan')
>>>  print dan
'Hello, my name is dan and I am a LinuxGeek.
>>>
```


Recent website changes
----------------------

You can have a look at all the recent changes to this website at [github.com/daniellawrence/dansysadm.com](https://github.com/daniellawrence/dansysadm.com/commits/master)
